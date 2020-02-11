import 'package:demo_app/data/movie/datasources/search_movie_datasource_shared_preferencelocal_impl.dart';
import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:demo_app/data/movie/repositories/movie_repositories.dart';
import 'package:demo_app/pages/favorite/movie_detail_local.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoritePage();
  }
}

class _FavoritePage extends State<FavoritePage> {
  List<MovieDetailLocal> movieDetailLocalList;

  Future<MovieRepositoryImpl> get movieDetailLocalRepository async =>
      MovieRepositoryImpl(
          movieDetailLocalDatasource: MovieLocalDatasourceSharedPrefetenceImpl(
              sharedPreferences: await SharedPreferences.getInstance()));

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      final repository = await movieDetailLocalRepository;
      if (mounted) {
        List list = repository.getMovieDetailLocal();
        setState(() {
          movieDetailLocalList = list;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          movieDetailLocalList = null;
        });
      }
    }
  }

  Widget _buildMovieResultList() {
    return Center(
      child: ListView.builder(
        itemCount: movieDetailLocalList== null?0 :movieDetailLocalList.length,
        itemBuilder: _buildItemList,
      ),
    );
  }

  // Widget _buildProgressBar() {
  //   return Center(child: CircularProgressIndicator());
  // }

  Widget _buildItemList(BuildContext context, int index) {
    final movie = movieDetailLocalList[index];
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
                    builder: (context) => MovieDetailLocalPage(movie.imdbID)));
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: new Icon(
          Icons.favorite,
          color: Colors.blue[700],
        ),
        title: Text("Favorite",
            style: TextStyle(
              color: Colors.blue[700],
            )),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: _buildMovieResultList(),
    );
  }
}

class Priority {
  int id;
  String categoryPriority;
  Priority(this.id, this.categoryPriority);

  static List<Priority> getPriorities() {
    return <Priority>[
      Priority(1, "Soon"),
      Priority(2, "Tomorrow"),
      Priority(3, "If im on mood"),
      Priority(4, "Should I?")
    ];
  }
}
