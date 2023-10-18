abstract class BottomBarState {}

class TabState extends BottomBarState {
  final int currentIndex;

  TabState(this.currentIndex);
}