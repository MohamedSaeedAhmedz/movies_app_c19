import '../../data/models/movie_model.dart';

abstract class SearchRepository {
  Future<List<MovieModel>> searchMovies(String query);
}