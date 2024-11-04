import 'package:fininite_riverpod/core/controller/popular_movie_controller.dart';
import 'package:fininite_riverpod/core/controller/top_rated_movie_controller.dart';
import 'package:fininite_riverpod/core/controller/upcoming_movie_controller.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_popular_movie.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_upcoming_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_top_rated_movie.dart';
import 'package:fininite_riverpod/ui/widgets/widgettophome.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(topRatedControllerProvider.notifier).fetchTopRatedMovies();
    ref.read(popularControllerProvider.notifier).fetchPopularMovies();
    ref.read(upcomingControllerProvider.notifier).fetchUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const WidgetTopHome(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  style: AppFonts.poppins(fontSize: 14, color: whiteColor),
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: whiteColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: whiteColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                  ),
                ),
              ),
              const TopRatedMovieWidget(),
              const PopularMovieWidget(),
              const UpcomingMovieWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
