import 'dart:convert';

import 'package:meta/meta.dart';

class MovieDetail {
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
  MovieDetail(
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
      @required this.website});

  factory MovieDetail.fromNeoJson(Map<String, dynamic> json) {
    final title = json['Title'] as String;
    final year = json['Year'] as String;
    final rated = json['Rated'] as String;
    final released = json['Released'] as String;
    final runtime = json['Runtime'] as String;
    final genre = json['Genre'] as String;
    final director = json['Director'] as String;
    final writer = json['Writer'] as String;
    final actors = json['Actors'] as String;
    final plot = json['Plot'] as String;
    final language = json['Language'] as String;
    final country = json['Country'] as String;
    final awards = json['Awards'] as String;
    final poster = json['Poster'] as String;
    final metascore = json['Metascore'] as String;
    final imdbRating = json['ImdbRating'] as String;
    final imdbVotes = json['ImdbVotes'] as String;
    final imdbID = json['ImdbID'] as String;
    final type = json['Type'] as String;
    final dVD = json['DVD'] as String;
    final boxOffice = json['BoxOffice'] as String;
    final production = json['Production'] as String;
    final website = json['Website'] as String;

    return MovieDetail(
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
        website: website);
  }

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
        title: json['Title'],
        year: json['Year'],
        rated: json['Rated'],
        released: json['Released'],
        runtime: json['Runtime'],
        genre: json['Genre'],
        director: json['Director'],
        writer: json['Writer'],
        actors: json['Actors'],
        plot: json['Plot'],
        language: json['Language'],
        country: json['Country'],
        awards: json['Awards'],
        poster: json['Poster'],
        metascore: json['Metascore'],
        imdbRating: json['ImdbRating'],
        imdbVotes: json['ImdbVotes'],
        imdbID: json['ImdbID'],
        type: json['Type'],
        dVD: json['DVD'],
        boxOffice: json['BoxOffice'],
        production: json['Production'],
        website: json['Website']);
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
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
