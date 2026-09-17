import 'package:movies_app/features/home/data/models/movie_model.dart';

import '../../data/models/movie_details_model.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsModel> getMovieDetails(int movieId);

  Future<List<MovieModel>> getSimilarMovies(int movieId);
}