import 'package:fininite_riverpod/ui/widgets/movies/widget_popular_movie.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_upcoming_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_top_rated_movie.dart';
import 'package:fininite_riverpod/ui/widgets/widgettophome.dart';
import 'package:fininite_riverpod/core/controller/movie_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieControllerProvider.notifier).fetchTopRatedMovies();
    ref.read(movieControllerProvider.notifier).fetchPopularMovies();
    ref.read(movieControllerProvider.notifier).fetchUpcomingMovies();
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
