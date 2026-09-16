import 'package:movies_app/features/home/data/models/movie_model.dart';

import '../../data/models/movie_details_model.dart';
import '../repositories/movie_details_repository.dart';

class MovieDetailsBundle {
  final MovieDetailsModel details;
  final List<MovieModel> similarMovies;

  MovieDetailsBundle({required this.details, required this.similarMovies});
}

class GetMovieDetailsUseCase {
  final MovieDetailsRepository repository;

  GetMovieDetailsUseCase({required this.repository});

  Future<MovieDetailsBundle> call(int movieId) async {
    final results = await Future.wait([
      repository.getMovieDetails(movieId),
      repository.getSimilarMovies(movieId),
    ]);

    return MovieDetailsBundle(
      details: results[0] as MovieDetailsModel,
      similarMovies: results[1] as List<MovieModel>,
    );
  }
}