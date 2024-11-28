import '../../domain/entities/actor/actor.dart';
import '../../domain/entities/movie/movie.dart';
import '../../domain/entities/movie_detail/movie_detail.dart';
import '../../domain/entities/result.dart';

abstract interface class MovieRepository {
  Future<Result<List<Movie>>> getNowPlaying({int page = 2});
  Future<Result<List<Movie>>> getUpComing({int page = 2});
  Future<Result<MovieDetail>> getDetail({required int id});
  Future<Result<List<Actor>>> getActors({required int id});
}
