import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/search_movies_use_case.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchBloc({required this.searchMoviesUseCase}) : super(SearchInitial()) {
    on<SearchMoviesEvent>((event, emit) async {
      if (event.query.trim().isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        final movies = await searchMoviesUseCase(event.query.trim());

        emit(SearchSuccess(movies));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
