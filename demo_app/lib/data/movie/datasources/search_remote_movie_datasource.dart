
import 'dart:convert';
import 'package:demo_app/data/movie/models/movie.dart';
import 'package:demo_app/network/movie_ws_client.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

abstract class MovieRemoteDatasource{
   Future<List<Movie>> getMovie();
}


class MovieRemoteDatasourceImpl  implements MovieRemoteDatasource{
  final MovieWsClient client;

  MovieRemoteDatasourceImpl({@required this.client});

  factory MovieRemoteDatasourceImpl.create() {
    return MovieRemoteDatasourceImpl(
      client: MovieWsClientImpl(http.Client()),
    );
  }

  @override
  Future<List<Movie>> getMovie() async {
   final response = await client.get("http://www.omdbapi.com/?apikey=68afa52b&t=doraemon");
    String json = response.body;
    List<Movie> movies = [];
    Map<String, dynamic> decodedJson = jsonDecode(json);
    Map<String, dynamic> datesDecoded = decodedJson['near_earth_objects'];
    datesDecoded.forEach((key, value) {
      value.forEach((listItem) {
        movies.add(Movie.fromNeoJson(listItem as Map<String, dynamic>));
      });
    });
    return movies;
  }

}