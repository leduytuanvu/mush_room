import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/features/device/home/bloc/home_event.dart';
import 'package:mush_room/features/device/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeRefreshEvent) {
      try {
        yield HomeLoadingState();
        await Future.delayed(const Duration(seconds: 2));
        yield HomeSuccessState();
      } on DioError catch (error) {
        error.showDialogDioException();
        yield HomeInitialState();
      } catch (error) {
        error.toString().showDialogCatchException(error.toString());
        yield HomeInitialState();
      }
    }
  }
}
