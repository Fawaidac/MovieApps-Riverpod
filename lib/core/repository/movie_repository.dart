import 'dart:convert';
import 'package:fininite_riverpod/core/model/detail_movie_model.dart';
import 'package:fininite_riverpod/core/model/detail_video_movie_model.dart';
import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  final String apiUrl;
  final String token;

  MovieRepository({required this.apiUrl, required this.token});

  Future<Movie> fetchTopRatedMovies(int page) async {
    final response = await http.get(
      Uri.parse('$apiUrl/top_rated?language=en-US&page=$page'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<Movie> fetchPopularMovies(int page) async {
    final response = await http.get(
      Uri.parse('$apiUrl/popular?language=en-US&page=$page'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<Movie> fetchUpcomingMovies(int page) async {
    final response = await http.get(
      Uri.parse('$apiUrl/upcoming?language=en-US&page=$page'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<DetailMovie> getDetailMovie(int movieId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$movieId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return DetailMovie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail movies');
    }
  }

  Future<DetailVideoMovie> getVideoDetailMovie(int movieId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$movieId/videos'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return DetailVideoMovie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load videos detail movies');
    }
  }

  Future<Movie> fetchRecommendationMovie(int movieId, int page) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$movieId/recommendations?language=en-US&page=$page'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load recommendation detail movies');
    }
  }
}

final movieRepositoryProvider = Provider((ref) => MovieRepository(
      apiUrl: ApiConfig.apiUrl,
      token: ApiConfig.token,
    ));
