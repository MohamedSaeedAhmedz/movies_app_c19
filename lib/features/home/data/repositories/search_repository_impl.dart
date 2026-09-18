import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_remote_data_source.dart';
import '../models/movie_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final moviesJson = await remoteDataSource.searchMovies(query);

    return moviesJson
        .map((movie) => MovieModel.fromJson(movie))
        .toList();
  }
}