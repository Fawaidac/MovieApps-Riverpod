import 'dart:convert';

import 'package:fininite_riverpod/core/model/movie_model.dart';
import 'package:fininite_riverpod/utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  final String apiUrl;
  final String token;

  SearchRepository({required this.apiUrl, required this.token});

  Future<Movie> searchMovie(String query, int page) async {
    final response = await http.get(
      Uri.parse(
          '$apiUrl/search/movie?query=$query&include_adult=false&language=en-US&page=$page'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }
}

final searchRepositoryProvider = Provider((ref) => SearchRepository(
      apiUrl: ApiConfig.apiSearchUrl,
      token: ApiConfig.token,
    ));
