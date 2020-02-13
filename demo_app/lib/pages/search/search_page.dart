import 'package:demo_app/data/movie/datasources/search_remote_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie.dart';
import 'package:demo_app/network/movie_ws_client.dart';
import 'package:demo_app/pages/movie_detail/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  Widget appTitleBar = Text('Search Video',
      style: TextStyle(
        color: Colors.blue[700],
      ));
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.blue[700],
  );
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Movie> _movieList;
  List<Movie> _movieScrollList;
  bool isInitOnloadPage = false;

  ScrollController _scrollController = new ScrollController();
  int initCount = 1;

  _SearchPage() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _movieList = new List();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
      initCount= 1;
    });
  }

  @override
  void initState() {
    isInitOnloadPage = true;
    super.initState();
    _getScrollData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getScrollData();
      }
    });
  }

  @override
  void dispose() {
    _filter.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  MovieRemoteDatasource get movies =>
      MovieRemoteDatasourceImpl(client: MovieWsClientImpl(http.Client()));

  // void _getData() async {
  //   try {
  //     final list = await movies.getMovieResult(_searchText);
  //     if (mounted) {
  //       setState(() {
  //         _movieScrollList = list;
  //       });
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       setState(() {
  //         _movieList = null;
  //       });
  //     }
  //   }
  // }

  void _getScrollData() async {
    try {
      final listScroll =
          await movies.getMovieResultPage(_searchText, initCount.toString());
      if (mounted) {
        setState(() {
          _movieScrollList = listScroll;
          _movieList.addAll(_movieScrollList);
          initCount++;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _movieList = null;
        });
      }
    }
  }

  void _onSearchSubmit() {
    setState(() {
      if (this.actionIcon.icon == Icons.search) {
        this.actionIcon = new Icon(Icons.close, color: Colors.blue[700]);
        var textField = new TextField(
          style: new TextStyle(color: Colors.blue[700]),
          controller: _filter,
          decoration: new InputDecoration(
              prefix: new Icon(
                Icons.search,
                color: Colors.blue[700],
              ),
              hintText: "Movie title...",
              hintStyle: new TextStyle(color: Colors.blue[700])),
          onSubmitted: (String value) {
            isInitOnloadPage = false;
            _searchText = value;
            // _getData();
            _getScrollData();
          },
        );
        this.appTitleBar = textField;
      } else {
        this.actionIcon = new Icon(Icons.search, color: Colors.blue[700]);
        this.appTitleBar = new Text("Search",
            style: TextStyle(
              color: Colors.blue[700],
            ));
      }
    });
  }

  Widget _buildMovieResultList() {
    if (_movieList == null && !isInitOnloadPage) {
      return _buildProgressBar();
    } else {
      return Center(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: isInitOnloadPage ? 0 : _movieList.length,
          itemBuilder: _buildItemList,
        ),
      );
    }
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildItemList(BuildContext context, int index) {
    final movie = _movieList[index];
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: new Image.network(
            movie.poster,
            fit: BoxFit.cover,
            width: 100.0,
          ),

          title: new Text(
            movie.title,
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(movie.year,
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal))
              ]),
          //trailing: ,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie.id)));
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: appTitleBar,
        // leading: IconButton(icon: Icon(Icons.menu), onPressed: (){}),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          new IconButton(
              icon: actionIcon,
              onPressed: () {
                _onSearchSubmit();
              })
        ],
      ),
      body: _buildMovieResultList(),
    );
  }
}
