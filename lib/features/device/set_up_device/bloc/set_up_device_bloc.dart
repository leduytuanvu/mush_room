import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/features/device/set_up_device/bloc/set_up_device_event.dart';
import 'package:mush_room/features/device/set_up_device/bloc/set_up_device_state.dart';

import '../../../../core/repositories/auth_repository.dart';

class SetUpDeviceBloc extends Bloc<SetUpDeviceEvent, SetUpDeviceState> {
  final AuthRepository authRepository;
  SetUpDeviceBloc(this.authRepository) : super(SetUpDeviceInitialState());

  @override
  Stream<SetUpDeviceState> mapEventToState(SetUpDeviceEvent event) async* {
    try {
      if (event is SetUpDeviceResetEvent) {}
    } on DioError catch (error) {
      error.showDialogDioException();
      yield SetUpDeviceInitialState();
    } catch (error) {
      error.toString().showDialogCatchException(error.toString());
      yield SetUpDeviceInitialState();
    }
  }
}
