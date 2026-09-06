abstract class HomeEvent {}

class ChangeNavIndexEvent extends HomeEvent {
  final int index;

  ChangeNavIndexEvent(this.index);
}