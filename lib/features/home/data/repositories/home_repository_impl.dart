import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';
import '../models/movie_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieModel>> getMovies() async {
    final moviesJson = await remoteDataSource.getMovies();

    return moviesJson.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
