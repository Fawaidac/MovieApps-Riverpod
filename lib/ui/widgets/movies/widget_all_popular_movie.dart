import 'package:card_loading/card_loading.dart';
import 'package:fininite_riverpod/core/controller/movie_controller.dart';
import 'package:fininite_riverpod/utils/date_formatter.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllPopularMovieWidget extends ConsumerWidget {
  const AllPopularMovieWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(movieControllerProvider);
    final isLoading = ref.watch(movieControllerProvider.notifier).isLoading;
    final hasMoreData = ref.watch(movieControllerProvider.notifier).hasMoreData;
    final movies = controller?.results ?? [];

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!isLoading &&
              hasMoreData &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            ref.read(movieControllerProvider.notifier).fetchAllPopularMovies();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: isLoading ? 5 : movies.length,
          itemBuilder: (context, index) {
            if (isLoading) {
              return _loadDataMovie();
            } else {
              final movie = movies[index];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    movie.posterPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${ApiConfig.imageUrl}${movie.posterPath}',
                              fit: BoxFit.cover,
                              width: 120,
                              height: 170,
                            ),
                          )
                        : CardLoading(
                            height: 170,
                            width: 120,
                            borderRadius: BorderRadius.circular(10),
                          ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title ?? '',
                            style: AppFonts.montserrat(
                              fontSize: 16,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                            // overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Rating: ${(movie.voteAverage! * 10).toStringAsFixed(0)}%',
                            style: AppFonts.montserrat(
                              fontSize: 14,
                              color: whiteColor,
                            ),
                          ),
                          Text(
                            formatDate(movie.releaseDate ?? ""),
                            style: AppFonts.montserrat(
                              fontSize: 12,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _loadDataMovie() {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardLoading(
            height: 170,
            width: 120,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 5),
          CardLoading(
            height: 10,
            width: 120,
            borderRadius: BorderRadius.circular(5),
            margin: const EdgeInsets.only(bottom: 3),
          ),
          CardLoading(
            margin: const EdgeInsets.only(bottom: 3),
            height: 10,
            width: 80,
            borderRadius: BorderRadius.circular(5),
          ),
          CardLoading(
              height: 10, width: 100, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
  }
}
