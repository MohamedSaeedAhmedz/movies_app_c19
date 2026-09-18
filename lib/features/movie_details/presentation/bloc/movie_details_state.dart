import 'package:movies_app/features/home/data/models/movie_model.dart';

import '../../data/models/movie_details_model.dart';

abstract class MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel details;
  final List<MovieModel> similarMovies;

  MovieDetailsSuccess({required this.details, required this.similarMovies});
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}