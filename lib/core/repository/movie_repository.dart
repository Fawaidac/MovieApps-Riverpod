import 'dart:convert';
import 'package:fininite_riverpod/core/model/movie_model.dart';
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
}
