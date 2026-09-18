import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchRemoteDataSource {
  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://movies-api.accel.li/api/v2/list_movies.json?query_term=$query',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['data']['movies'] ?? [];
    } else {
      throw Exception('Failed to search movies');
    }
  }
}