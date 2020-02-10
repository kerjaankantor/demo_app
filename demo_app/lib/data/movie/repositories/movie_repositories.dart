import 'package:demo_app/data/movie/datasources/search_local_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:flutter/material.dart';

abstract class MovieRepository {
  Future<void> setMovieDetailByDate(
      String date, MovieDetailLocal movieDetailLocal);
  List<MovieDetailLocal> getMovieDetailLocal();
}

class MovieRepositoryImpl implements MovieRepository{
  final MovieDetailLocalDatasource movieDetailLocalDatasource;

  MovieRepositoryImpl({@required this.movieDetailLocalDatasource});

  @override
  List<MovieDetailLocal> getMovieDetailLocal() {
    return movieDetailLocalDatasource.getMovieDetailLocal();
  }

  @override
  Future<void> setMovieDetailByDate(String date, MovieDetailLocal movieDetailLocal) {
    movieDetailLocalDatasource.setMovieDetailByDate(date, movieDetailLocal);
    return null;
  }
  
} 