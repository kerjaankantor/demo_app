import 'dart:convert';

import 'package:flutter/foundation.dart';

class MovieDetailLocal {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final String dVD;
  final String boxOffice;
  final String production;
  final String website;
  final String isView;
  final String priority;
  final String createdDate;

  MovieDetailLocal(
      {@required this.title,
      @required this.year,
      @required this.rated,
      @required this.released,
      @required this.runtime,
      @required this.genre,
      @required this.director,
      @required this.writer,
      @required this.actors,
      @required this.plot,
      @required this.language,
      @required this.country,
      @required this.awards,
      @required this.poster,
      @required this.metascore,
      @required this.imdbRating,
      @required this.imdbVotes,
      @required this.imdbID,
      @required this.type,
      @required this.dVD,
      @required this.boxOffice,
      @required this.production,
      @required this.website,
      @required this.isView,
      @required this.priority,
      @required this.createdDate});


  factory MovieDetailLocal.fromNeoJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final year = json['year'] as String;
    final rated = json['rated'] as String;
    final released = json['released'] as String;
    final runtime = json['runtime'] as String;
    final genre = json['genre'] as String;
    final director = json['director'] as String;
    final writer = json['writer'] as String;
    final actors = json['actors'] as String;
    final plot = json['plot'] as String;
    final language = json['language'] as String;
    final country = json['country'] as String;
    final awards = json['awards'] as String;
    final poster = json['poster'] as String;
    final metascore = json['metascore'] as String;
    final imdbRating = json['imdbRating'] as String;
    final imdbVotes = json['imdbVotes'] as String;
    final imdbID = json['imdbID'] as String;
    final type = json['type'] as String;
    final dVD = json['dVD'] as String;
    final boxOffice = json['boxOffice'] as String;
    final production = json['production'] as String;
    final website = json['website'] as String;
    final isView = json['isView'] as String;
    final priority = json['priority'] as String;
    final createdDate = json['createdDate'] as String;

    return MovieDetailLocal(
        title: title,
        year: year,
        rated: rated,
        released: released,
        runtime: runtime,
        genre: genre,
        director: director,
        writer: writer,
        actors: actors,
        plot: plot,
        language: language,
        country: country,
        awards: awards,
        poster: poster,
        metascore: metascore,
        imdbRating: imdbRating,
        imdbVotes: imdbVotes,
        imdbID: imdbID,
        type: type,
        dVD: dVD,
        boxOffice: boxOffice,
        production: production,
        website: website,
        isView: isView,
        priority: priority,
        createdDate: createdDate);
  }

  factory MovieDetailLocal.fromJson(Map<String, dynamic> json) {
    return MovieDetailLocal(
        title: json['title'],
        year: json['year'],
        rated: json['rated'],
        released: json['released'],
        runtime: json['runtime'],
        genre: json['genre'],
        director: json['director'],
        writer: json['writer'],
        actors: json['actors'],
        plot: json['plot'],
        language: json['language'],
        country: json['country'],
        awards: json['awards'],
        poster: json['poster'],
        metascore: json['metascore'],
        imdbRating: json['imdbRating'],
        imdbVotes: json['imdbVotes'],
        imdbID: json['imdbID'],
        type: json['type'],
        dVD: json['dVD'],
        boxOffice: json['boxOffice'],
        production: json['production'],
        website: json['website'],
        isView: json['isView'],
        priority: json['priority'],
        createdDate: json['createdDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'rated': rated,
      'released': released,
      'runtime': runtime,
      'genre': genre,
      'director': director,
      'writer': writer,
      'actors': actors,
      'plot': plot,
      'language': language,
      'country': country,
      'awards': awards,
      'poster': poster,
      'metascore': metascore,
      'imdbRating': imdbRating,
      'imdbVotes': imdbVotes,
      'imdbID': imdbID,
      'type': type,
      'dVD': dVD,
      'boxOffice': boxOffice,
      'production': production,
      'website': website,
      'isView':isView,
      'priority':priority,
      'createdDate': createdDate
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
