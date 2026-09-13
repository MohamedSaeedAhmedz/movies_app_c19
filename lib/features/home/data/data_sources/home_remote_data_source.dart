import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeRemoteDataSource {
  Future<List<dynamic>> getMovies() async {
    final response = await http.get(
      Uri.parse('https://movies-api.accel.li/api/v2/list_movies.json'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['data']['movies'];
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
