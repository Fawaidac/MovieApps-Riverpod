import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';
import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieController extends ChangeNotifier {
  final MovieRepository movieRepository;

  Movie? movie;
  bool isLoading = false;
  bool hasMoreData = true;
  int currentPage = 1;

  MovieController({required this.movieRepository});

  Future<void> fetchTopRatedMovies() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    notifyListeners();

    try {
      final newMovies = await movieRepository.fetchTopRatedMovies(currentPage);
      if (movie == null) {
        movie = newMovies;
      } else {
        movie!.results!.addAll(newMovies.results!);
      }
      currentPage++;

      if (newMovies.results!.length < 10) {
        hasMoreData = false;
      }
    } catch (error) {
      throw Exception(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPopularMovies() async {
    isLoading = true;
    notifyListeners();

    try {
      final newMovies = await movieRepository.fetchPopularMovies(currentPage);
      if (movie == null) {
        movie = newMovies;
      } else {
        movie!.results!.addAll(newMovies.results!);
      }
    } catch (error) {
      throw Exception(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

final movieControllerProvider = ChangeNotifierProvider<MovieController>((ref) {
  return MovieController(
    movieRepository: MovieRepository(
      apiUrl: ApiConfig.apiUrl,
      token: ApiConfig.token,
    ),
  );
});
