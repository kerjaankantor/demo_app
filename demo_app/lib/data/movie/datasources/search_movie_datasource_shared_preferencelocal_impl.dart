import 'dart:convert';

import 'package:demo_app/data/movie/datasources/search_local_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:demo_app/data/movie/models/setting.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieLocalDatasourceSharedPrefetenceImpl
    implements MovieDetailLocalDatasource {
  final SharedPreferences sharedPreferences;

  MovieLocalDatasourceSharedPrefetenceImpl({@required this.sharedPreferences});

  @override
  Future<void> setMovieDetailLocal(
      String id, MovieDetailLocal movieDetailLocal) async {
    if (movieDetailLocal == null) {
      await sharedPreferences.remove('movie_cache_$id');
    } else {
      final json = jsonEncode(movieDetailLocal);
      sharedPreferences.setString('movie_cache_$id', json);
    }
  }

  @override
  List<MovieDetailLocal> getMovieDetailLocal() {
    Set<String> keySet = sharedPreferences.getKeys();
    List<MovieDetailLocal> movieDetailLocalList = [];
    if (keySet.isNotEmpty) {
      for (var key in keySet) {
        if (key != "movie_cache_setting_key") {
          Map<String, dynamic> decodedJson =
              jsonDecode(sharedPreferences.getString(key));
          MovieDetailLocal detail = MovieDetailLocal.fromNeoJson(decodedJson);
          movieDetailLocalList.add(detail);
        }
      }
      return movieDetailLocalList;
    } else {
      return null;
    }
  }

  @override
  Future<MovieDetailLocal> getDetail(String id) async {
    String result = sharedPreferences.getString('movie_cache_$id');
    Map<String, dynamic> decodedJson = jsonDecode(result);
    MovieDetailLocal detail = MovieDetailLocal.fromNeoJson(decodedJson);
    if (detail != null) {
      return detail;
    } else {
      return null;
    }
  }

  @override
  Future<void> setHiddenFav(String id, String hiddenVal) async {
    if (hiddenVal != null) {
      await sharedPreferences.remove('movie_cache_$id');
      sharedPreferences.setString('movie_cache_$id', hiddenVal);
    }
  }

  @override
  Future<SettingFav> getHiddenFav(String id) async {
    String result = sharedPreferences.getString('movie_cache_$id');
    SettingFav detail = SettingFav(hiddenVal: result);
    if (detail != null) {
      return detail;
    } else {
      return null;
    }
  }

   @override
  Future<void> deleteMovieDetailLocal(String id) async {
      await sharedPreferences.remove('movie_cache_$id');
  }
}
