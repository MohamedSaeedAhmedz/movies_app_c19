part of 'locale_bloc.dart';

abstract class LocaleEvent {}

class ChangeLocaleEvent extends LocaleEvent {
  final String languageCode;
  ChangeLocaleEvent({required this.languageCode});
}