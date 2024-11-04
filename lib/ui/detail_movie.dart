import 'package:card_loading/card_loading.dart';
import 'package:fininite_riverpod/core/controller/detail_movie_controller.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/detail_movie_header.dart';
import 'package:fininite_riverpod/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class DetailMovieScreen extends ConsumerStatefulWidget {
  final int movieId;
  const DetailMovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends ConsumerState<DetailMovieScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(detailControllerProvider.notifier)
          .getDetailMovie(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final detailMovie = ref.watch(detailControllerProvider);
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: detailMovie == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: whiteColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailMovie.backdropPath != null
                        ? DetailMovieHeader(detailMovie: detailMovie)
                        : CardLoading(
                            height: 250,
                            width: deviceSize.width,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: whiteColor,
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: primaryColor,
                                  child: Text(
                                    detailMovie.voteAverage != null
                                        ? '${(detailMovie.voteAverage! * 10).toStringAsFixed(0)}%'
                                        : 'N/A',
                                    style: AppFonts.montserrat(
                                        fontSize: 14,
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text(
                                "Vote\nAverage",
                                style: AppFonts.montserrat(
                                    fontSize: 14, color: whiteColor),
                              )
                            ],
                          ),
                          const Gap(14),
                          Text(
                            detailMovie.overview ?? "",
                            style: AppFonts.montserrat(
                                fontSize: 12,
                                color: whiteColor,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
