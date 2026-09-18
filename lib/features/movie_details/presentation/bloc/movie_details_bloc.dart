import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_movie_details_use_case.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  MovieDetailsBloc({required this.getMovieDetailsUseCase})
    : super(MovieDetailsLoading()) {
    on<GetMovieDetailsEvent>((event, emit) async {
      emit(MovieDetailsLoading());

      try {
        final bundle = await getMovieDetailsUseCase(event.movieId);

        emit(
          MovieDetailsSuccess(
            details: bundle.details,
            similarMovies: bundle.similarMovies,
          ),
        );
      } catch (e) {
        emit(MovieDetailsError(e.toString()));
      }
    });
  }
}