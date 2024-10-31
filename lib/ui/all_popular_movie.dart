import 'package:fininite_riverpod/core/controller/movie_controller.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_all_popular_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllPopularMovie extends ConsumerStatefulWidget {
  const AllPopularMovie({super.key});

  @override
  ConsumerState<AllPopularMovie> createState() => _AllPopularMovieState();
}

class _AllPopularMovieState extends ConsumerState<AllPopularMovie> {
  @override
  void initState() {
    super.initState();
    ref.read(movieControllerProvider.notifier).fetchAllPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Popular Movie",
          style: AppFonts.montserrat(
              fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: whiteColor,
          ),
        ),
      ),
      backgroundColor: primaryColor,
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            AllPopularMovieWidget(),
          ],
        ),
      )),
    );
  }
}
