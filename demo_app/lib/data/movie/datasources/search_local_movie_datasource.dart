import 'package:demo_app/data/movie/models/movie_detail_local.dart';

abstract class MovieDetailLocalDatasource {
  List<MovieDetailLocal> getMovieDetailLocal();
  Future<void> setMovieDetailByDate(String date, MovieDetailLocal movieDetailLocal);
  Future<MovieDetailLocal> getDetail(String id);
}
