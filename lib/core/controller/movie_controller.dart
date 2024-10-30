import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';

class MovieController extends StateNotifier<Movie?> {
  final MovieRepository movieRepository;

  MovieController(this.movieRepository) : super(null);

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

  Future<void> fetchAllPopularMovies() async {
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
    } catch (error) {
      throw Exception(error);
    } finally {
      isLoading = false;
    }
  }

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

final movieRepositoryProvider = Provider((ref) => MovieRepository(
      apiUrl: ApiConfig.apiUrl,
      token: ApiConfig.token,
    ));

final movieControllerProvider =
    StateNotifierProvider<MovieController, Movie?>((ref) {
  final repository = ref.read(movieRepositoryProvider);
  return MovieController(repository);
});
