import 'package:fininite_riverpod/core/controller/recommendation_movie_controller.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/load_movie_placeholder.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/movie_card.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetRecommendationMovie extends ConsumerWidget {
  final int movieId;
  const WidgetRecommendationMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(recommendationControllerProvider);
    final isLoading =
        ref.watch(recommendationControllerProvider.notifier).isLoading;
    final hasMoreData =
        ref.watch(recommendationControllerProvider.notifier).hasMoreData;
    final movies = controller?.results ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Text(
            'Recommendation',
            style: AppFonts.montserrat(
              fontSize: 16,
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!isLoading &&
                  hasMoreData &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                ref
                    .read(recommendationControllerProvider.notifier)
                    .fetchRecommendationMovies(movieId);
              }
              return true;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: isLoading ? 5 : movies.length,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return const LoadMoviePlaceholder();
                } else {
                  final movie = movies[index];
                  return MovieCard(movie: movie);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
