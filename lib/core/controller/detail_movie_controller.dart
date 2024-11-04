import 'package:fininite_riverpod/core/model/detail_movie_model.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailMovieController extends StateNotifier<DetailMovie?> {
  MovieRepository movieRepository;

  DetailMovieController(this.movieRepository) : super(null);

  bool isLoading = false;

  Future<void> getDetailMovie(int movieId) async {
    if (isLoading) return;

    isLoading = true;
    try {
      final detailMovie = await movieRepository.getDetailMovie(movieId);
      state = detailMovie;
    } catch (e) {
      print('Error loading get detail results: $e');
      state = null;
    } finally {
      isLoading = false;
    }
  }
}

final detailControllerProvider =
    StateNotifierProvider<DetailMovieController, DetailMovie?>((ref) {
  final repository = ref.read(movieRepositoryProvider);
  return DetailMovieController(repository);
});
