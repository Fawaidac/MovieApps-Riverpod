import 'package:fininite_riverpod/core/model/detail_video_movie_model.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailVideoMovieController extends StateNotifier<DetailVideoMovie?> {
  MovieRepository movieRepository;

  DetailVideoMovieController(this.movieRepository) : super(null);

  bool isLoading = false;

  Future<void> getVideoDetailMovie(int movieId) async {
    if (isLoading) return;

    isLoading = true;
    try {
      final detailMovie = await movieRepository.getVideoDetailMovie(movieId);
      state = detailMovie;
    } catch (e) {
      print('Error loading get detail results: $e');
      state = null;
    } finally {
      isLoading = false;
    }
  }

  void resetState() {
    state = null;
  }
}

final detailVideosControllerProvider =
    StateNotifierProvider<DetailVideoMovieController, DetailVideoMovie?>((ref) {
  final repository = ref.read(movieRepositoryProvider);
  return DetailVideoMovieController(repository);
});
