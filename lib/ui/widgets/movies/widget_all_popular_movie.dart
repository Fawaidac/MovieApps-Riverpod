import 'package:card_loading/card_loading.dart';
import 'package:fininite_riverpod/core/controller/popular_movie_controller.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class AllPopularMovieWidget extends ConsumerWidget {
  const AllPopularMovieWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(popularControllerProvider);
    final isLoading = ref.watch(popularControllerProvider.notifier).isLoading;
    final hasMoreData =
        ref.watch(popularControllerProvider.notifier).hasMoreData;
    final movies = controller?.results ?? [];

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!isLoading &&
              hasMoreData &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            ref.read(popularControllerProvider.notifier).fetchPopularMovies();
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
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            width: 120,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${ApiConfig.imageUrl}${movie.posterPath}'),
                                    fit: BoxFit.cover)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: primaryColor.withOpacity(0.8),
                                child: Text(
                                  '${index + 1}',
                                  style: AppFonts.montserrat(
                                      fontSize: 12,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
                          ),
                          Text(
                            'Rating: ${(movie.voteAverage! * 10).toStringAsFixed(0)}%',
                            style: AppFonts.montserrat(
                              fontSize: 14,
                              color: whiteColor,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            movie.overview ?? "",
                            style: AppFonts.montserrat(
                              fontSize: 12,
                              color: whiteColor,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
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
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardLoading(
            height: 170,
            width: 120,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardLoading(
                  height: 15,
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
                    height: 10,
                    width: 100,
                    borderRadius: BorderRadius.circular(5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
