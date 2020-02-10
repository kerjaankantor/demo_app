import 'package:demo_app/data/movie/datasources/search_movie_datasource_shared_preferencelocal_impl.dart';
import 'package:demo_app/data/movie/datasources/search_remote_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie_detail.dart';
import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:demo_app/data/movie/repositories/movie_repositories.dart';
import 'package:demo_app/network/movie_ws_client.dart';
import 'package:demo_app/pages/favorite/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailPage extends StatefulWidget {
  final String id;
  MovieDetailPage(this.id);
  @override
  State<StatefulWidget> createState() {
    return _MovieDetailPage(this.id);
  }
}

class _MovieDetailPage extends State<MovieDetailPage> {
  final String id;
  String idVal;
  _MovieDetailPage(this.id);
  MovieDetail movieDetail;
  List<Priority> _priority = Priority.getPriorities();
  List<DropdownMenuItem<Priority>> _dropDownMenuItems;
  Priority _selectedPriority;
  bool isView = false;

  Future<MovieRepository> get movieDetailLocalRepository async =>
      MovieRepositoryImpl(
          movieDetailLocalDatasource: MovieLocalDatasourceSharedPrefetenceImpl(
              sharedPreferences: await SharedPreferences.getInstance()));

  @override
  void initState() {
    _dropDownMenuItems = _buildDropdownPriorityItems(_priority);
    _selectedPriority = _dropDownMenuItems[0].value;
    setState(() {
      this.idVal = id;
    });
    super.initState();
    _getData();
  }

  void _onSwitchChanged(bool value) {
    isView = false;
  }

  List<DropdownMenuItem<Priority>> _buildDropdownPriorityItems(
      List priorities) {
    List<DropdownMenuItem<Priority>> items = List();
    for (Priority priority in priorities) {
      items.add(DropdownMenuItem(
        value: priority,
        child: Text(
          priority.categoryPriority,
          style: TextStyle(color: Colors.blue[700]),
        ),
      ));
    }
    return items;
  }

  MovieRemoteDatasource get movies =>
      MovieRemoteDatasourceImpl(client: MovieWsClientImpl(http.Client()));

  _getData() async {
    try {
      final result = await movies.getMovieDetail(id);
      if (mounted) {
        setState(() {
          movieDetail = result;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          movieDetail = null;
        });
      }
    }
  }

  Widget _buildMovieDetail(BuildContext context) {
    if (movieDetail == null) {
      return _buildProgressBar();
    } else {
      return Center(child: _buildMovieDetailsPage(context));
    }
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  _buildMovieDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                _buildMovieImagesWidgets(),
                _buildMovieTitleWidget(),
                SizedBox(height: 12.0),
                _buildYearHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildYearInfoData(),
                SizedBox(height: 12.0),
                _buildRatedHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildRatedInfoData(),
                SizedBox(height: 12.0),
                _buildReleasedHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildReleasedInfoData(),
                SizedBox(height: 12.0),
                _buildGenreHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildGenreInfoData(),
                SizedBox(height: 12.0),
                _buildDirectorHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildDirectorInfoData(),
                SizedBox(height: 12.0),
                _buildWriterHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildWriterInfoData(),
                SizedBox(height: 12.0),
                _buildActorsHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildActorsInfoData(),
                SizedBox(height: 12.0),
                _buildPlotHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildPlotInfoData(),
                SizedBox(height: 12.0),
                _buildLanguageHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildLanguageInfoData(),
                SizedBox(height: 12.0),
                _buildCountryHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildCountryInfoData(),
                SizedBox(height: 12.0),
                _buildAwardsHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildAwardsInfoData(),
                SizedBox(height: 12.0),
                _buildImdbRatingHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildImdbRatingInfoData(),
                SizedBox(height: 4.0),
                _buildPriorityHeader(),
                SizedBox(height: 4.0),
                _buildPriorityInfoData(),
                SizedBox(height: 4.0),
                _buildViewHeader(),
                SizedBox(height: 4.0),
                _buildViewInfoData(),
                SizedBox(height: 4.0),
                _buildSaveHeader(),
                SizedBox(height: 4.0),
                _buildSaveInfoData(context),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildMovieImagesWidgets() {
    return Container(
        child:
            Center(child: Image.network(movieDetail.poster, fit: BoxFit.fill)));
  }

  _buildYearHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Year",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildMovieTitleWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          movieDetail.title == null ? "-" : movieDetail.title,
          style: TextStyle(fontSize: 20.0, color: Colors.blue[700]),
        ),
      ),
    );
  }

  _buildRatedHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Rated",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildRatedInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.rated == null ? "-" : movieDetail.rated,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildReleasedHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Released",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildReleasedInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.released == null ? "-" : movieDetail.released,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildGenreHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Genre",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildGenreInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.genre == null ? "-" : movieDetail.genre,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildDirectorHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Director",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildDirectorInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.director == null ? "-" : movieDetail.director,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildWriterHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Writer",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildWriterInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.writer == null ? "-" : movieDetail.writer,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildActorsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Actors",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildActorsInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.awards == null ? "-" : movieDetail.awards,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildPlotHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Plot",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildPlotInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.plot == null ? "-" : movieDetail.plot,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildLanguageHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Language",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildLanguageInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.language == null ? "-" : movieDetail.language,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildCountryHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Country",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildCountryInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.country == null ? "-" : movieDetail.country,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildAwardsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Awards",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildAwardsInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.awards == null ? "-" : movieDetail.awards,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildImdbRatingHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Imdb Rating",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildImdbRatingInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.imdbRating == null ? "-" : movieDetail.imdbRating,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildYearInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        movieDetail.year == null ? "-" : movieDetail.year,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildPriorityHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Priority",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildPriorityInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: DropdownButton(
        value: _selectedPriority,
        items: _dropDownMenuItems,
        onChanged: (Priority value) {},
      ),
    );
  }

  _buildViewHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "View",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildViewInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Switch(value: isView, onChanged: _onSwitchChanged),
    );
  }

  _buildSaveHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Save As Favorite",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildSaveInfoData(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.lightBlueAccent,
          elevation: 5.0,
          color: Colors.blue[700],
          child: MaterialButton(
            minWidth: 10.0,
            height: 42.0,
            onPressed: () {
              _onSaveLocal(movieDetail, 1, false, DateTime.now());
              // Navigator.of(context).pushNamed(SystemConstants.FAVORITE_PAGE);
              Navigator.of(context).pop();
              _showDialog(context);
            },
            child:
                Text('Save As Favorite', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("NOTIFCATION"),
            content: Text("Move has been save"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Close'))
            ],
          );
        });
  }

  _onSaveLocal(MovieDetail movieDetail, int priority, bool isView,
      DateTime createdDate) async {
    final repository = await movieDetailLocalRepository;
    MovieDetailLocal detailLocal = MovieDetailLocal(
        title: movieDetail.title,
        year: movieDetail.year,
        rated: movieDetail.rated,
        released: movieDetail.released,
        runtime: movieDetail.runtime,
        genre: movieDetail.genre,
        director: movieDetail.director,
        writer: movieDetail.writer,
        actors: movieDetail.actors,
        plot: movieDetail.poster,
        language: movieDetail.language,
        country: movieDetail.country,
        awards: movieDetail.awards,
        poster: movieDetail.poster,
        metascore: movieDetail.metascore,
        imdbRating: movieDetail.imdbRating,
        imdbVotes: movieDetail.imdbVotes,
        imdbID: movieDetail.imdbID,
        type: movieDetail.type,
        dVD: movieDetail.dVD,
        boxOffice: movieDetail.boxOffice,
        production: movieDetail.production,
        website: movieDetail.writer,
        isView: isView,
        priority: priority,
        createdDate: createdDate);
    repository.setMovieDetailByDate(createdDate.toString(), detailLocal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.blue[700],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Movie Detail",
            style: TextStyle(
              color: Colors.blue[700],
            )),
        backgroundColor: Colors.white,
      ),
      body: _buildMovieDetail(context),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
