import '../../../data/repositories/movie_repository.dart';
import '../../entities/movie_detail/movie_detail.dart';
import '../../entities/result.dart';
import '../usecase.dart';
import 'get_movie_detail_param.dart';

class GetMovieDetail
    implements Usecase<Result<MovieDetail>, GetMovieDetailParam> {
  final MovieRepository _movieRepository;

  GetMovieDetail({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<MovieDetail>> call(GetMovieDetailParam params) async {
    var movieDetailResult =
        await _movieRepository.getDetail(id: params.movie.id);

    return switch (movieDetailResult) {
      Success(value: final movieDetail) => Result.success(movieDetail),
      Failed(:final message) => Result.failed(message),
    };
  }
}
