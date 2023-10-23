abstract class BottomBarEvent {}

class TabSelected extends BottomBarEvent {
  final int index;

  TabSelected(this.index);
}

class ResetBottomBarEvent extends BottomBarEvent {}