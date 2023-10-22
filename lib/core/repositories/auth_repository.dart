import 'package:jwt_decode/jwt_decode.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/environments/config_manager.dart';
import 'package:mush_room/core/models/auth/auth_model.dart';
import 'package:mush_room/core/models/user/user_model.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/features/auth/login/bloc/login_event.dart';
import 'dart:convert';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<UserModel?> login(LoginSubmittedEvent event) async {
    try {
      final apiBaseUrl = ConfigManager.config.apiBaseUrl;
      // Define the login endpoint
      final loginEndpoint = '$apiBaseUrl/iot/signIn';
      final Map<String, dynamic> data = {
        'username': event.email,
        'password': event.password,
      };
      // Make a POST request to the login endpoint
      final response = await _dioClient.post(loginEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final authModel = AuthModel.fromJson(response.data['data']);

        Map<String, dynamic> payload = Jwt.parseJwt(authModel.accessToken);

        final id = payload['user']['id'];
        final phoneNumber = payload['user']['phoneNumber'];
        final email = payload['user']['email'];
        final group = payload['user']['group'];
        // final exprire = payload['exp'];

        final user = UserModel(id: id, phone: phoneNumber, name: email, email: email, avatarUrl: "", role: group);
        String userJson = jsonEncode(user.toJson());
        DateTime? expiryDate = Jwt.getExpiryDate(authModel.accessToken);

        final sharedPreferenceService = injector<SharedPreferenceService>();
        await sharedPreferenceService.setAccessToken(authModel.accessToken);
        await sharedPreferenceService.setRefreshToken(authModel.refreshToken);
        await sharedPreferenceService.setUser(userJson);
        // await sharedPreferenceService.setExpiry(expiryDate);

        // final userJsonTmp = sharedPreferenceService.getUser();
        // if (userJsonTmp != null) {
        //   Map<String, dynamic> userMap = jsonDecode(userJson);
        //   UserModel user = UserModel.fromJson(userMap);
        //   print(user);
        // }
        return user;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
