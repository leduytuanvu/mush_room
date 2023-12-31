import 'package:dio/dio.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/models/auth/responses/confirm_forgot_password_response.dart';
import 'package:mush_room/core/models/auth/responses/delete_response.dart';
import 'package:mush_room/core/models/auth/responses/forgot_password_response.dart';
import 'package:mush_room/core/models/auth/responses/login_response.dart';
import 'package:mush_room/core/models/auth/responses/register_response.dart';
import 'package:mush_room/core/models/auth/responses/update_password_response.dart';
import 'package:mush_room/core/models/auth/responses/update_user_response.dart';
import 'package:mush_room/core/models/user/user_model.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_event.dart';
import 'package:mush_room/features/auth/login/bloc/login_event.dart';
import 'package:mush_room/features/auth/register/bloc/register_event.dart';
import 'package:mush_room/features/profile/bloc/infor_profile/infor_profile_event.dart';

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
        final sharedPreferenceService = injector<SharedPreferenceService>();
        // Parse the response JSON and create an AuthModel
        final loginResponse = LoginResponse.fromJson(response.data['data']);
        await sharedPreferenceService.setAccessToken(loginResponse.accessToken);
        await sharedPreferenceService
            .setRefreshToken(loginResponse.refreshToken);
        await sharedPreferenceService.setExpiry(loginResponse.expiresIn);

        // Set the JWT Bearer token in the Dio client's headers
        _dioClient.setJwtBearerToken(loginResponse.accessToken);

        final getInforUser = AppConstants.apiGetInforUser;
        final tmpResponse = await _dioClient.get(getInforUser);

        if (tmpResponse.statusCode == 200) {
          final getUserInforResponse =
              UserModel.fromJson(tmpResponse.data['data']);
          // String userJson = jsonEncode(getUserInforResponse.toJson());
          // await sharedPreferenceService.setUser(userJson);
          await sharedPreferenceService.setEmail(getUserInforResponse.email);
          await sharedPreferenceService
              .setPhone(getUserInforResponse.phoneNumber);
          await sharedPreferenceService.setUsername(getUserInforResponse.name);
          return getUserInforResponse;
        }
      }
      return null;
    } on DioError {
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
    } on DioError {
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
    } on DioError {
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
    } on DioError {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<UpdateUserResponse?> updateUser(
      InforProfileUpdateUserEvent event) async {
    try {
      final updateUserEndpoint = AppConstants.apiUpdateUserUrl;

      final Map<String, dynamic> data = {
        'name': event.username,
        'phoneNumber': event.phone,
      };
      // Make a POST request to the login endpoint
      final response = await _dioClient.put(updateUserEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final updateUserResponse = UpdateUserResponse.fromJson(response.data);

        return updateUserResponse;
      } else {
        return null;
      }
    } on DioError {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<UpdatePasswordResponse?> updatePassword(
      InforProfileUpdatePasswordEvent event) async {
    try {
      final updatePasswordEndpoint = AppConstants.apiUpdatePasswordUrl;

      final Map<String, dynamic> data = {
        'oldPassword': event.oldPassword,
        'newPassword': event.newPassword,
      };
      // Make a POST request to the login endpoint
      final response =
          await _dioClient.post(updatePasswordEndpoint, data: data);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final updatePasswordResponse =
            UpdatePasswordResponse.fromJson(response.data);

        return updatePasswordResponse;
      } else {
        return null;
      }
    } on DioError {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<DeleteResponse?> deleteAccount() async {
    try {
      final deleteAccountEndpoint = AppConstants.apiDeleteAccountUrl;
      // Make a POST request to the login endpoint
      final response = await _dioClient.delete(deleteAccountEndpoint);
      // Check if the response status code indicates success (e.g., 200)
      if (response.statusCode == 200) {
        // Parse the response JSON and create an AuthModel
        final deleteAccountResponse = DeleteResponse.fromJson(response.data);

        return deleteAccountResponse;
      } else {
        return null;
      }
    } on DioError {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
