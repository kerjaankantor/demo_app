import 'dart:convert';

import 'package:demo_app/data/movie/datasources/search_local_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:flutter/material.dart';

abstract class MovieRepository {
  Future<void> setMovieDetailByDate(
      String date, MovieDetailLocal movieDetailLocal);
  List<MovieDetailLocal> getMovieDetailLocal();
  Future<MovieDetailLocal> getDetail(String id);
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieDetailLocalDatasource movieDetailLocalDatasource;

  MovieRepositoryImpl({@required this.movieDetailLocalDatasource});

  @override
  List<MovieDetailLocal> getMovieDetailLocal() {
    return movieDetailLocalDatasource.getMovieDetailLocal();
  }

  @override
  Future<void> setMovieDetailByDate(
      String imdbID, MovieDetailLocal movieDetailLocal) {
    movieDetailLocalDatasource.setMovieDetailByDate(imdbID, movieDetailLocal);
    return null;
  }

  @override
  Future<MovieDetailLocal> getDetail(String id) async {
    final jsonString = await movieDetailLocalDatasource.getDetail(id);
    if (jsonString != null) {
      MovieDetailLocal detailLocal;
      String json = jsonEncode(jsonString);
      Map<String, dynamic> decodedJson = jsonDecode(json);
      detailLocal = MovieDetailLocal.fromNeoJson(decodedJson);
      return detailLocal;
    } else {
      return null;
    }
  }
}
