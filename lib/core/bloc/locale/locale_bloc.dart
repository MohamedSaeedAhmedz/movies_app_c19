import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(locale: Locale('en'))) {
    on<ChangeLocaleEvent>((event, emit) {
      emit(LocaleState(locale: Locale(event.languageCode)));
    });
  }
}