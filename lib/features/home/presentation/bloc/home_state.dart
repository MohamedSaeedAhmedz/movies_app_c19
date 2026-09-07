import '../../data/models/movie_model.dart';

abstract class HomeState {
  final int currentIndex;

  HomeState({this.currentIndex = 0});
}

class HomeInitial extends HomeState {
  HomeInitial({super.currentIndex});
}

class HomeNavChanged extends HomeState {
  HomeNavChanged(int currentIndex) : super(currentIndex: currentIndex);
}

class HomeMoviesLoading extends HomeState {
  HomeMoviesLoading({super.currentIndex});
}

class HomeMoviesSuccess extends HomeState {
  final List<MovieModel> movies;

  HomeMoviesSuccess(this.movies, {super.currentIndex});
}

class HomeMoviesError extends HomeState {
  final String message;

  HomeMoviesError(this.message, {super.currentIndex});
}
