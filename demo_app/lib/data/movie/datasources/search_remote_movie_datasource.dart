import 'dart:convert';
import 'package:demo_app/data/movie/models/movie.dart';
import 'package:demo_app/data/movie/models/movie_detail.dart';
import 'package:demo_app/network/movie_ws_client.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

abstract class MovieRemoteDatasource {
  Future<List<Movie>> getMovie();
  Future<List<Movie>> getMovieResult(String title);
  Future<MovieDetail> getMovieDetail(String id);
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final MovieWsClient client;

  MovieRemoteDatasourceImpl({@required this.client});

  factory MovieRemoteDatasourceImpl.create() {
    return MovieRemoteDatasourceImpl(
      client: MovieWsClientImpl(http.Client()),
    );
  }

  @override
  Future<List<Movie>> getMovie() async {
    final response =
        await client.get("http://www.omdbapi.com/?apikey=68afa52b&s=life");
    String json = response.body;
    List<Movie> movies = [];
    Map<String, dynamic> decodedJson = jsonDecode(json);
    List<dynamic> movieDecoded = decodedJson['Search'];
    for (int i = 0; i < movieDecoded.length; i++) {
      Map<String, dynamic> item = movieDecoded[i];
      movies.add(Movie.fromNeoJson(item));
    }
    return movies;
  }

  @override
  Future<List<Movie>> getMovieResult(String title) async {
    String url = 'http://www.omdbapi.com/?apikey=68afa52b&s=$title';
    final response = await client.get(url);
    String json = response.body;
    List<Movie> movies = [];
    Map<String, dynamic> decodedJson = jsonDecode(json);
    List<dynamic> movieDecoded = decodedJson['Search'];
    for (int i = 0; i < movieDecoded.length; i++) {
      Map<String, dynamic> item = movieDecoded[i];
      movies.add(Movie.fromNeoJson(item));
    }
    return movies;
  }

  @override
  Future<MovieDetail> getMovieDetail(String id)  async{
    String url = 'http://www.omdbapi.com/?apikey=68afa52b&i=$id';
    final response = await client.get(url);
    String json = response.body;
    MovieDetail detail;
    Map<String, dynamic> decodedJson = jsonDecode(json);
    detail= MovieDetail.fromNeoJson(decodedJson);
    return detail;
  }
}
