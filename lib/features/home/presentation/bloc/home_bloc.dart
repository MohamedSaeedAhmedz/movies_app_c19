import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_movies_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase getMoviesUseCase;

  HomeBloc({required this.getMoviesUseCase}) : super(HomeInitial()) {
    on<ChangeNavIndexEvent>((event, emit) {
      emit(HomeNavChanged(event.index));
    });

    on<GetMoviesEvent>((event, emit) async {
      emit(HomeMoviesLoading(currentIndex: state.currentIndex));

      try {
        final movies = await getMoviesUseCase();

        emit(HomeMoviesSuccess(movies, currentIndex: state.currentIndex));
      } catch (e) {
        emit(HomeMoviesError(e.toString(), currentIndex: state.currentIndex));
      }
    });
  }
}
