import 'package:card_loading/card_loading.dart';
import 'package:fininite_riverpod/core/controller/detail_movie_controller.dart';
import 'package:fininite_riverpod/core/controller/detail_video_movie_controller.dart';
import 'package:fininite_riverpod/core/controller/recommendation_movie_controller.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/movies/component/detail_movie_header.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_recommendation_movie.dart';
import 'package:fininite_riverpod/utils/date_formatter.dart';
import 'package:fininite_riverpod/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends ConsumerStatefulWidget {
  final int movieId;
  const DetailMovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends ConsumerState<DetailMovieScreen> {
  YoutubePlayerController? ytController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(detailControllerProvider.notifier)
          .getDetailMovie(widget.movieId);
      ref
          .read(detailVideosControllerProvider.notifier)
          .getVideoDetailMovie(widget.movieId);
      ref
          .read(recommendationControllerProvider.notifier)
          .fetchRecommendationMovies(widget.movieId);
    });
  }

  @override
  void dispose() {
    ytController?.dispose();
    super.dispose();
  }

  void initializeYoutubePlayer(String videoKey) {
    ytController = YoutubePlayerController(
      initialVideoId: videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final detailMovie = ref.watch(detailControllerProvider);
    final listVideos = ref.watch(detailVideosControllerProvider);

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
                    listVideos == null ||
                            listVideos.results == null ||
                            listVideos.results!.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: whiteColor,
                            ),
                          )
                        : Container(
                            height: 215,
                            margin: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: listVideos.results?.length ?? 0,
                              itemBuilder: (context, index) {
                                final video = listVideos.results![index];
                                final videoKey = video.key;
                                if (videoKey != null && ytController == null) {
                                  initializeYoutubePlayer(videoKey);
                                }

                                return SizedBox(
                                  width: 250,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (videoKey != null) {
                                            initializeYoutubePlayer(videoKey);
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 250,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: ytController != null &&
                                                  ytController!
                                                          .initialVideoId ==
                                                      videoKey
                                              ? YoutubePlayer(
                                                  controller: ytController!,
                                                  showVideoProgressIndicator:
                                                      true,
                                                )
                                              : Container(
                                                  color: secondaryColor
                                                      .withOpacity(0.7),
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "images/youtube.png",
                                                        height: 50,
                                                      ),
                                                      Text(
                                                        "Tap to play",
                                                        style:
                                                            AppFonts.montserrat(
                                                          fontSize: 12,
                                                          color: whiteColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const Gap(8),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            formatDate(video.publishedAt ?? ""),
                                            style: AppFonts.montserrat(
                                                fontSize: 11,
                                                color: whiteColor,
                                                fontWeight: FontWeight.w300),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                      const Gap(8),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            video.name ?? 'No Title',
                                            style: AppFonts.montserrat(
                                                fontSize: 12,
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              ),
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
                          WidgetRecommendationMovie(
                            movieId: widget.movieId,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
