import 'package:demo_app/data/movie/models/movie_detail_local.dart';
import 'package:demo_app/data/movie/models/setting.dart';

abstract class MovieDetailLocalDatasource {
  List<MovieDetailLocal> getMovieDetailLocal();
  Future<void> setMovieDetailLocal(String id, MovieDetailLocal movieDetailLocal);
  Future<MovieDetailLocal> getDetail(String id);
  Future<void> setHiddenFav(String id, String hiddenVal);
  Future<SettingFav> getHiddenFav(String id);
  Future<void> deleteMovieDetailLocal(String id) ;
}
