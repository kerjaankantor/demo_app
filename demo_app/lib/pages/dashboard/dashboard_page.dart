import 'package:demo_app/data/movie/datasources/search_movie_datasource_shared_preferencelocal_impl.dart';
import 'package:demo_app/data/movie/datasources/search_remote_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie.dart';
import 'package:demo_app/data/movie/models/setting.dart';
import 'package:demo_app/data/movie/repositories/movie_repositories.dart';
import 'package:demo_app/network/movie_ws_client.dart';
import 'package:demo_app/pages/widgets/not_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardPage();
  }
}

class _DashboardPage extends State<DashboardPage> {
  List<Movie> _movieList;
  List<int> itemList = List();
  bool _isShowProgressBar = false;

  Future<MovieRepository> get movieDetailLocalRepository async =>
      MovieRepositoryImpl(
          movieDetailLocalDatasource: MovieLocalDatasourceSharedPrefetenceImpl(
              sharedPreferences: await SharedPreferences.getInstance()));

  @override
  void initState() {
    super.initState();
    _getData();
  }

  MovieRemoteDatasource get movies =>
      MovieRemoteDatasourceImpl(client: MovieWsClientImpl(http.Client()));

  void _getData() async {
    try {
      final repository = await movieDetailLocalRepository;
      if (mounted) {
        SettingFav result = await repository.getHiddenFav('setting_key');
        if (result.hiddenVal != '_hidden') {
          try {
            final list = await movies.getMovie();
            if (mounted) {
              setState(() {
                _movieList = list;
              });
            }
          } catch (e) {
            if (mounted) {
              setState(() {
                _movieList = null;
                _isShowProgressBar = true;
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _buildMovieList(BuildContext context) {
    if (_movieList == null && _isShowProgressBar) {
      return _buildProgressBar();
    } else {
      return Center(child: _buildItemList(context));
    }
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  _buildDashBoardPage(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      Flexible(
          flex: 1,
          child: Container(
              color: Colors.white,
              child: Column(children: <Widget>[
                bannerArea(),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 5, right: 5, bottom: 10),
                  child: Text(
                    'Movie Recommendation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Currently the application just store favorite movie, with all token has same preference key, and movie recommendation still hit imdb API for searching with hard code parameter value',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
                Container(
                  child: Expanded(
                   child: _buildMovieList(context),
                  ),
                ),
              ]))),
    ]));
  }

  bannerArea() {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(right: 20, top: 20, left: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset("images/logo.png",
              fit: BoxFit.cover, 
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'My Video App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,  color: Colors.blue[700],),
            ),
            Text('oh my this my first baby App flutter, YAY!!!',
            style: new TextStyle( color: Colors.blue[700]))
          ],
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }

  Widget _buildItemList(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180.0,
              childAspectRatio: 0.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          itemCount: _movieList == null ? 0 : _movieList.length,
          itemBuilder: (context, index) {
            return NotMovieWidget(
                notMovieTitle: _movieList[index].title,
                notMovieYear: _movieList[index].year,
                notMoviePosterUrl: _movieList[index].poster,
                id: _movieList[index].id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: new Icon(
            Icons.dashboard,
            color: Colors.blue[700],
          ),
          title: Text("Dashboard",
              style: TextStyle(
                color: Colors.blue[700],
              )),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: <Widget>[],
        ),
        body: Container(
          // child: _buildMovieList(context),
          child: _buildDashBoardPage(context),
        ));
  }
}
