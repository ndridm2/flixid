enum MovieListCategories { nowPlaying, upcoming }

class GetMovieListParam {
  final int page;
  final MovieListCategories category;

  GetMovieListParam({
    this.page = 2,
    required this.category,
  });
}
