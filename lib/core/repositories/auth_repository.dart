import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/models/auth/responses/confirm_forgot_password_response.dart';
import 'package:mush_room/core/models/auth/responses/forgot_password_response.dart';
import 'package:mush_room/core/models/auth/responses/login_response.dart';
import 'package:mush_room/core/models/auth/responses/register_response.dart';
import 'package:mush_room/core/models/user/user_model.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_event.dart';
import 'package:mush_room/features/auth/login/bloc/login_event.dart';
import 'package:mush_room/features/auth/register/bloc/register_event.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<UserModel?> login(LoginSubmittedEvent event) async {
    try {
      final loginEndpoint = AppConstants.apiLoginUrl;

      final Map<String, dynamic> data = {
        'username': event.email,
        'password': event.password,
      };
      // Make a POST request to the login endpoint
      final response = await _dioClient.post(loginEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final loginResponse = LoginResponse.fromJson(response.data['data']);

        Map<String, dynamic> payload = Jwt.parseJwt(loginResponse.accessToken);

        final id = payload['user']['id'];
        final phoneNumber = payload['user']['phoneNumber'];
        final email = payload['user']['email'];
        final group = payload['user']['group'];
        final exprire = payload['exp'];

        final user = UserModel(
          id: id,
          phone: phoneNumber,
          name: email,
          email: email,
          avatarUrl: "",
          role: group,
        );

        String userJson = jsonEncode(user.toJson());
        // DateTime? expiryDate = Jwt.getExpiryDate(authModel.accessToken);
        //
        // AppLogger.d("TEST" + expiryDate.toString());

        final sharedPreferenceService = injector<SharedPreferenceService>();
        await sharedPreferenceService.setAccessToken(loginResponse.accessToken);
        await sharedPreferenceService
            .setRefreshToken(loginResponse.refreshToken);
        await sharedPreferenceService.setUser(userJson);
        await sharedPreferenceService.setExpiry(exprire.toString());

        return user;
      } else {
        return null;
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<RegisterResponse?> register(RegisterSubmittedEvent event) async {
    try {
      final registerEndpoint = AppConstants.apiRegisterUrl;

      final Map<String, dynamic> data = {
        'email': event.email,
        'name': event.name,
        'phoneNumber': event.phoneNumber,
        'password': event.password,
      };
      // Make a POST request to the login endpoint
      final response = await _dioClient.post(registerEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final registerResponse =
            RegisterResponse.fromJson(response.data['data']);

        return registerResponse;
      } else {
        return null;
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<ForgotPasswordResponse?> forgotPassword(
      ForgotPasswordSubmittedEvent event) async {
    try {
      final forgotPasswordEndpoint = AppConstants.apiForgotPasswordUrl;

      final Map<String, dynamic> data = {'username': event.email};
      // Make a POST request to the login endpoint
      final response =
          await _dioClient.post(forgotPasswordEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final forgotPasswordResponse =
            ForgotPasswordResponse.fromJson(response.data['data']);

        return forgotPasswordResponse;
      } else {
        return null;
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<ConfirmForgotPasswordResponse?> changePasswordWhenForgot(
      ChangePasswordSubmittedEvent event) async {
    try {
      final confirmForgotPasswordEndpoint =
          AppConstants.apiConfirmForgotPasswordUrl;

      final Map<String, dynamic> data = {
        'username': event.email,
        'password': event.newPassword,
        'confirmationCode': event.verificationCode,
      };
      // Make a POST request to the login endpoint
      final response =
          await _dioClient.post(confirmForgotPasswordEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final forgotPasswordResponse =
            ConfirmForgotPasswordResponse.fromJson(response.data);

        return forgotPasswordResponse;
      } else {
        return null;
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<ConfirmForgotPasswordResponse?> changePassword(
      ChangePasswordSubmittedEvent event) async {
    try {
      final confirmForgotPasswordEndpoint = AppConstants.apiChangePasswordUrl;

      final Map<String, dynamic> data = {
        'oldPassword': event.email,
        'newPassword': event.newPassword,
      };
      // Make a POST request to the login endpoint
      final response =
          await _dioClient.post(confirmForgotPasswordEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final forgotPasswordResponse =
            ConfirmForgotPasswordResponse.fromJson(response.data);

        return forgotPasswordResponse;
      } else {
        return null;
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
