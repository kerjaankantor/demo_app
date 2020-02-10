import 'dart:convert';

import 'package:demo_app/data/movie/datasources/search_local_movie_datasource.dart';
import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieLocalDatasourceSharedPrefetenceImpl
    implements MovieDetailLocalDatasource {
  final SharedPreferences sharedPreferences;

  MovieLocalDatasourceSharedPrefetenceImpl({@required this.sharedPreferences});

  @override
  Future<void> setMovieDetailByDate(
      String date, MovieDetailLocal movieDetailLocal) async {
    if (movieDetailLocal == null) {
      await sharedPreferences.remove('movie_cache_$date');
    } else {
      final json = jsonEncode(movieDetailLocal);
      sharedPreferences.setString('movie_cache_$date', json);
    }
  }

  @override
  List<MovieDetailLocal> getMovieDetailLocal() {
    Set<String> keySet = sharedPreferences.getKeys();
    List<MovieDetailLocal> movieDetailLocalList =[];
    if (keySet.isNotEmpty) {
      for (var key in keySet) {
        if (key != "HIDDEN_FAVORITE") {
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
}
