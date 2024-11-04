import 'package:fininite_riverpod/core/controller/popular_movie_controller.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/all_popular_movie.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/load_movie_placeholder.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class PopularMovieWidget extends ConsumerWidget {
  const PopularMovieWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(popularControllerProvider);
    final isLoading = ref.watch(popularControllerProvider.notifier).isLoading;
    final movies = controller?.results ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Movies',
              style: AppFonts.montserrat(
                fontSize: 16,
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllPopularMovie(),
                    ));
              },
              child: Text(
                'See More',
                style: AppFonts.montserrat(
                  fontSize: 12,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
        const Gap(20),
        SizedBox(
          height: 220,
          child: ListView.builder(
            itemCount: isLoading ? 5 : movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (isLoading) {
                return const LoadMoviePlaceholder();
              } else {
                final movie = movies[index];
                return MovieCard(movie: movie);
              }
            },
          ),
        )
      ],
    );
  }
}
