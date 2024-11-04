import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRatedMovieController extends StateNotifier<Movie?> {
  final MovieRepository movieRepository;

  TopRatedMovieController(this.movieRepository) : super(null);

  bool isLoading = false;
  bool hasMoreData = true;
  int currentPage = 1;

  Future<void> fetchTopRatedMovies() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;

    try {
      final newMovies = await movieRepository.fetchTopRatedMovies(currentPage);

      final updatedResults = List<Results>.from(state?.results ?? [])
        ..addAll(newMovies.results!);

      state = Movie(
        page: newMovies.page,
        results: updatedResults,
        totalPages: newMovies.totalPages,
        totalResults: newMovies.totalResults,
      );

      currentPage++;

      if (newMovies.results!.length < 10) {
        hasMoreData = false;
      }
    } catch (error) {
      throw Exception(error);
    } finally {
      isLoading = false;
    }
  }
}

final topRatedControllerProvider =
    StateNotifierProvider<TopRatedMovieController, Movie?>((ref) {
  final repository = ref.read(movieRepositoryProvider);
  return TopRatedMovieController(repository);
});
