import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/environments/config_manager.dart';
import 'package:mush_room/core/models/auth/auth_model.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/features/auth/login/bloc/login_event.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<AuthModel> login(LoginSubmitted event) async {
    final apiBaseUrl = ConfigManager.config.apiBaseUrl;
    // Define the login endpoint
    final loginEndpoint = '$apiBaseUrl/iot/signIn';
    final Map<String, dynamic> data = {
      'username': event.username,
      'password': event.password,
    };
    // Make a POST request to the login endpoint
    final response = await _dioClient.post(loginEndpoint, data: data);
    // Check if the response status code indicates success (e.g., 200)
    if (response.statusCode == 200) {
      // Parse the response JSON and create an AuthModel
      final authModel = AuthModel.fromJson(response.data['data']);
      final sharedPreferenceService = injector<SharedPreferenceService>();
      sharedPreferenceService.setAccessToken(authModel.accessToken);
      sharedPreferenceService.setRefreshToken(authModel.refreshToken);
      return authModel;
    } else {
      throw Exception('Login failed. Status Code: ${response.statusCode}');
    }
  }
}
