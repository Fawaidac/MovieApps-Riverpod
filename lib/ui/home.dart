import 'package:fininite_riverpod/core/controller/movie_controller.dart';
import 'package:fininite_riverpod/core/repository/movie_repository.dart';
import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/movies/widget_top_rated_movie.dart';
import 'package:fininite_riverpod/ui/widgets/widgettophome.dart';

class HomeScreen extends ConsumerWidget {
  // Change to ConsumerWidget
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create the MovieController provider here
    final movieController = ref.watch(movieControllerProvider);

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              WidgetTopHome(),
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
                      borderSide: BorderSide(color: Colors.grey),
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
              // Pass the provider reference to WidgetTopRatedMovie
              WidgetTopRatedMovie(controller: movieController),
            ],
          ),
        ),
      ),
    );
  }
}
