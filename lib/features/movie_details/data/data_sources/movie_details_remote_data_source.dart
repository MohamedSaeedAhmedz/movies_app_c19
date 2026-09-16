import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieDetailsRemoteDataSource {
  static const _baseUrl = 'https://yts.gg/api/v2';

  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/movie_details.json?movie_id=$movieId&with_images=true&with_cast=true',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['data']['movie'];
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<dynamic>> getSimilarMovies(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie_suggestions.json?movie_id=$movieId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['data']['movies'] ?? [];
    } else {
      throw Exception('Failed to load similar movies');
    }
  }
}