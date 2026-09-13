import '../../data/models/movie_model.dart';
import '../repositories/home_repository.dart';

class GetMoviesUseCase {
  final HomeRepository repository;

  GetMoviesUseCase({required this.repository});

  Future<List<MovieModel>> call() {
    return repository.getMovies();
  }
}
