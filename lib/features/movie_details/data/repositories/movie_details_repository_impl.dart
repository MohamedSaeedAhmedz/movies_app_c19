import 'package:movies_app/features/home/data/models/movie_model.dart';

import '../../domain/repositories/movie_details_repository.dart';
import '../data_sources/movie_details_remote_data_source.dart';
import '../models/movie_details_model.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final json = await remoteDataSource.getMovieDetails(movieId);

    return MovieDetailsModel.fromJson(json);
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    final moviesJson = await remoteDataSource.getSimilarMovies(movieId);

    return moviesJson.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}