import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularMovieController extends StateNotifier<Movie?> {
  final MovieRepository movieRepository;

  PopularMovieController(this.movieRepository) : super(null);

  bool isLoading = false;
  bool hasMoreData = true;
  int currentPage = 1;

  Future<void> fetchPopularMovies() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;

    try {
      final newMovies = await movieRepository.fetchPopularMovies(currentPage);

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

final popularControllerProvider =
    StateNotifierProvider<PopularMovieController, Movie?>((ref) {
  final repository = ref.read(movieRepositoryProvider);
  return PopularMovieController(repository);
});
