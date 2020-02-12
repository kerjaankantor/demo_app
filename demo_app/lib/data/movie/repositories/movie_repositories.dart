import 'dart:convert';

import 'package:demo_app/data/movie/datasources/search_local_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:demo_app/data/movie/models/setting.dart';
import 'package:flutter/material.dart';

abstract class MovieRepository {
  Future<void> setMovieDetailByDate(
      String date, MovieDetailLocal movieDetailLocal);
  List<MovieDetailLocal> getMovieDetailLocal();
  Future<MovieDetailLocal> getDetail(String id);
  Future<void> setHiddenRec(String id, String hiddenVal);
  Future<SettingFav> getHiddenFav(String id);
  Future<void> deleteMovieDetailLocal(String id) ;
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
    movieDetailLocalDatasource.setMovieDetailLocal(imdbID, movieDetailLocal);
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

  @override
  Future<SettingFav> getHiddenFav(String id) async {
    final jsonString = await movieDetailLocalDatasource.getHiddenFav(id);
    if (jsonString != null) {
      SettingFav settingFav;
      String json = jsonEncode(jsonString);
      Map<String, dynamic> decodedJson = jsonDecode(json);
      settingFav = SettingFav.fromNeoJson(decodedJson);
      return settingFav;
    } else {
      return null;
    }
  }

  @override
  Future<void> setHiddenRec(String id, String hiddenVal) {
    movieDetailLocalDatasource.setHiddenFav(id, hiddenVal);
    return null;
  }

  @override
  Future<void> deleteMovieDetailLocal(String id) {
    movieDetailLocalDatasource.deleteMovieDetailLocal(id);
    return null;
  }
}
