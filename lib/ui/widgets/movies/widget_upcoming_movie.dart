import 'package:fininite_riverpod/core/controller/upcoming_movie_controller.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/load_movie_placeholder.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/movie_card.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingMovieWidget extends ConsumerWidget {
  const UpcomingMovieWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(upcomingControllerProvider);
    final isLoading = ref.watch(upcomingControllerProvider.notifier).isLoading;
    final hasMoreData =
        ref.watch(upcomingControllerProvider.notifier).hasMoreData;
    final movies = controller?.results ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Text(
            'Upcoming Movies',
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
                    .read(upcomingControllerProvider.notifier)
                    .fetchUpcomingMovies();
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
