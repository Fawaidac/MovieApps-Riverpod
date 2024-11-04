import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/core/repository/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchController extends StateNotifier<Movie?> {
  final SearchRepository searchRepository;

  SearchController(this.searchRepository) : super(null);

  bool isLoading = false;
  bool hasMoreData = true;
  int currentPage = 1;

  Future<void> fetchSearchMovie(String query) async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;

    try {
      final newMovies = await searchRepository.searchMovie(query, currentPage);

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
      print('Error loading search results: $error');
      state = null;
    } finally {
      isLoading = false;
    }
  }
}

final searchControllerProvider =
    StateNotifierProvider<SearchController, Movie?>((ref) {
  final repository = ref.read(searchRepositoryProvider);
  return SearchController(repository);
});
