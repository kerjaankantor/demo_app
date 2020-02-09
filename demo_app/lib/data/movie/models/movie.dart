import 'dart:convert';

import 'package:meta/meta.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final String poster;
  Movie({
    @required this.id,
    @required this.title,
    @required this.year,
    @required this.poster,
  });

  factory Movie.fromNeoJson(Map<String, dynamic> json) {
    final imdbID = json['imdbID'] as String;
    final title = json['Title'] as String;
    final year = json['Year'] as String;
    final poster = json['Poster'] as String;
    
    return Movie(
      id: imdbID,
      title: title,
      year: year,
      poster: poster,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['imdbID'],
        title: json['Title'],
        year: json['Year'],
        poster: json['Poster']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': year,
      'poster': poster
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
