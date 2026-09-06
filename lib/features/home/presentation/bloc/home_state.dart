abstract class HomeState {}

class HomeInitial extends HomeState {
  final int currentIndex;

  HomeInitial({this.currentIndex = 0});
}

class HomeNavChanged extends HomeState {
  final int currentIndex;

  HomeNavChanged(this.currentIndex);
}