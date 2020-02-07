import 'dart:convert';

import 'package:meta/meta.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final String rated;
  final String plot;
  final String poster;
  Movie({
    @required this.id,
    @required this.title,
    @required this.year,
    @required this.rated,
    @required this.plot,
    @required this.poster,
  });

  factory Movie.fromNeoJson(Map<String, dynamic> json) {
    return Movie(
      id: json['imdbID'],
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      plot: json['Plot'],
      poster: json['poster'],
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['Title'],
        year: json['Year'],
        rated: json['Rated'],
        plot: json['Plot'],
        poster: json['Poster']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': year,
      'rated': rated,
      'plot': plot,
      'poster': poster
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
