import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingMovieController extends StateNotifier<Movie?> {
  final MovieRepository movieRepository;

  UpcomingMovieController(this.movieRepository) : super(null);

  bool isLoading = false;
  bool hasMoreData = true;
  int currentPage = 1;

  Future<void> fetchUpcomingMovies() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;

    try {
      final newMovies = await movieRepository.fetchUpcomingMovies(currentPage);

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

final upcomingControllerProvider =
    StateNotifierProvider<UpcomingMovieController, Movie?>((ref) {
  final repository = ref.read(movieRepositoryProvider);
  return UpcomingMovieController(repository);
});
