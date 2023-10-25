import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/extensions/confirm/confirm.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_event.dart';
import 'package:mush_room/features/profile/bloc/profile/profile_event.dart';
import 'package:mush_room/features/profile/bloc/profile/profile_state.dart';

import '../../../../core/repositories/auth_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;
  ProfileBloc(this.authRepository) : super(ProfileInitialState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    try {
      if (event is ProfileDeleteAccountEvent) {
        NavigationService().goBack();
        yield ProfileLoadingState();
        await Future.delayed(const Duration(seconds: 1));
        final response = await authRepository.deleteAccount();
        if (response == null) {
          yield ProfileDeleteAccountReturnNullState();
        } else {
          const String messageRegisterSuccess = "Deleted account successfully";
          appNavigation(LoginPage(), isRemoveAll: true);
          messageRegisterSuccess.showDialogConfirm(
            messageRegisterSuccess,
            () {
              NavigationService().goBack();
            },
          );
          yield ProfileInitialState();
          final bottomBarBloc = injector<BottomBarBloc>();
          bottomBarBloc.add(ResetBottomBarEvent());
        }
      }
    } on DioError catch (error) {
      error.showDialogDioException();
      yield ProfileInitialState();
    } catch (error) {
      error.toString().showDialogCatchException(error.toString());
      yield ProfileInitialState();
    }
  }
}
