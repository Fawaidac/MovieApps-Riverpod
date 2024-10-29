import 'package:flutter/material.dart';
import 'package:fininite_riverpod/core/controller/movie_controller.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:gap/gap.dart';

class WidgetTopRatedMovie extends StatefulWidget {
  final MovieController controller;

  const WidgetTopRatedMovie({super.key, required this.controller});

  @override
  _WidgetTopRatedMovieState createState() => _WidgetTopRatedMovieState();
}

class _WidgetTopRatedMovieState extends State<WidgetTopRatedMovie> {
  @override
  void initState() {
    super.initState();
    widget.controller.fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Top Rated Movies',
            style: AppFonts.montserrat(
              fontSize: 16,
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 250, // Adjust height as needed
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!widget.controller.isLoading &&
                  widget.controller.hasMoreData &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                widget.controller.fetchTopRatedMovies();
              }
              return true;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Change to horizontal
              itemCount:
                  (widget.controller.topRatedMovies?.results?.length ?? 0) +
                      (widget.controller.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index <
                    (widget.controller.topRatedMovies?.results?.length ?? 0)) {
                  final movie =
                      widget.controller.topRatedMovies!.results![index];
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 8),
                    child: Column(
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
                            : Container(
                                height: 170,
                                width: 120,
                                color: Colors.grey,
                              ),
                        const Gap(8),
                        Text(
                          movie.title ?? '',
                          style: AppFonts.montserrat(
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Rating: ${(movie.voteAverage! * 10).toStringAsFixed(0)}%',
                          style: AppFonts.montserrat(
                              fontSize: 10, color: whiteColor),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: whiteColor,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
