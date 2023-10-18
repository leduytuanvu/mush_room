import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_event.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(TabState(0));

  @override
  Stream<BottomBarState> mapEventToState(BottomBarEvent event) async* {
    if (event is TabSelected) {
      yield TabState(event.index);
    }
  }
}