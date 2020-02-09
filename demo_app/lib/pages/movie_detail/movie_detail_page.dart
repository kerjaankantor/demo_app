import 'package:demo_app/data/movie/datasources/search_remote_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie_detail.dart';
import 'package:demo_app/network/movie_ws_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    setState(() {
      this.idVal = id;
    });
    super.initState();
    _getData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Movie Detail"),
      ),
      body: _buildMovieDetail(context),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
