import 'package:fininite_riverpod/core/controller/popular_movie_controller.dart';
import 'package:fininite_riverpod/core/controller/search_controller.dart';
import 'package:fininite_riverpod/core/controller/top_rated_movie_controller.dart';
import 'package:fininite_riverpod/core/controller/upcoming_movie_controller.dart';
import 'package:fininite_riverpod/ui/search.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_popular_movie.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_upcoming_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_top_rated_movie.dart';
import 'package:fininite_riverpod/ui/widgets/widgettophome.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(topRatedControllerProvider.notifier).fetchTopRatedMovies();
    ref.read(popularControllerProvider.notifier).fetchPopularMovies();
    ref.read(upcomingControllerProvider.notifier).fetchUpcomingMovies();
  }

  void toggleSearch() {
    Future.microtask(() {
      if (mounted) {
        setState(() {
          isSearching = !isSearching;
        });

        if (!isSearching) {
          FocusScope.of(context).unfocus();
        }
      }
    });
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
                  controller: searchController,
                  style: AppFonts.poppins(fontSize: 14, color: whiteColor),
                  onTap: () {
                    if (!isSearching) {
                      toggleSearch();
                    }
                  },
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                    ref
                        .read(searchControllerProvider.notifier)
                        .fetchSearchMovie(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        isSearching ? Icons.close : Icons.search,
                        color: whiteColor,
                      ),
                      onPressed: toggleSearch,
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
              Visibility(
                visible: isSearching,
                child: const SearchScreen(),
              ),
              Visibility(
                visible: !isSearching,
                child: const Column(
                  children: [
                    TopRatedMovieWidget(),
                    PopularMovieWidget(),
                    UpcomingMovieWidget(),
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
