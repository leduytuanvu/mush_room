import 'package:dio/dio.dart';
import 'package:mush_room/core/models/auth/auth_model.dart';
import 'package:mush_room/core/models/auth/requests/login_request.dart';
import 'package:mush_room/core/models/user/user_model.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/features/auth/login/bloc/login_event.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<AuthModel> login(LoginSubmitted event) async {
    // Assuming you store user data in SharedPreferences.
    // await _sharedPreferenceService.setString('user', user.toJson());
    return AuthModel(id: 1, name: "name", email: event.username, avatarUrl: event.password, accessToken: "access_token", refreshToken: "refresh_token");
  }
}