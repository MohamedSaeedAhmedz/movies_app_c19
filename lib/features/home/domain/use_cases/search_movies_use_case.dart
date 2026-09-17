import '../../data/models/movie_model.dart';
import '../repositories/search_repository.dart';

class SearchMoviesUseCase {
  final SearchRepository repository;

  SearchMoviesUseCase({
    required this.repository,
  });

  Future<List<MovieModel>> call(String query) {
    return repository.searchMovies(query);
  }
}