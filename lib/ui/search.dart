import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fininite_riverpod/core/controller/search_controller.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchControllerProvider);
    final searchController = ref.read(searchControllerProvider.notifier);
    final query = ref.watch(searchQueryProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !searchController.isLoading &&
            searchController.hasMoreData) {
          searchController.fetchSearchMovie(query);
        }
        return false;
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: searchResults == null
            ? Center(
                child: Text(
                  'Error loading results. Please try again.',
                  style: AppFonts.montserrat(fontSize: 14, color: whiteColor),
                ),
              )
            : searchResults.results == null || searchResults.results!.isEmpty
                ? Center(
                    child: Text(
                      'No results found',
                      style:
                          AppFonts.montserrat(fontSize: 14, color: whiteColor),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchResults.results!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == searchResults.results!.length) {
                        return searchController.isLoading
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: whiteColor,
                                )),
                              )
                            : const SizedBox.shrink();
                      }
                      final movie = searchResults.results![index];
                      return ListTile(
                        leading: movie.posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                width: 50,
                              )
                            : const Icon(Icons.movie),
                        title: Text(
                          movie.title ?? 'Unknown Title',
                          style: AppFonts.montserrat(
                              fontSize: 14, color: whiteColor),
                        ),
                        subtitle: Text(
                          'Release Date: ${movie.releaseDate ?? 'N/A'}',
                          style: AppFonts.montserrat(
                              fontSize: 12, color: Colors.grey),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
