import 'package:dio/dio.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_logger.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sharedPreferenceService = injector<SharedPreferenceService>();
    final accessToken = sharedPreferenceService.getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Assuming 401 is the status code for unauthorized
      final sharedPreferenceService = injector<SharedPreferenceService>();
      final refreshToken = sharedPreferenceService.getRefreshToken();
      if (refreshToken != '') {
        try {
          // Assume refreshTokens is a function that refreshes the tokens and returns a Map<String, String> with the new tokens.
          final newTokens = await getNewToken(refreshToken);

          final sharedPreferenceService = injector<SharedPreferenceService>();
          sharedPreferenceService
              .setAccessToken(newTokens['accessToken'].toString());
          sharedPreferenceService
              .setRefreshToken(newTokens['refreshToken'].toString());
          sharedPreferenceService
              .setExpiry(int.parse(newTokens['expiresIn'].toString()));

          AppLogger.d(
              "Get new access and refresh token: ${newTokens['accessToken']}, ${newTokens['refreshToken']}");

          // Retry the failed request with the new token
          RequestOptions options = err.requestOptions;
          options.headers['Authorization'] =
              'Bearer ${newTokens['accessToken']}';
          try {
            // Re-try the request
            Response response = await Dio().fetch(options);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(err); // Return any new error
          }
        } catch (e) {
          return handler
              .next(err); // Return original error if token refresh fails
        }
      }
    }
    return handler
        .next(err); // If not unauthorized error, continue with error handling
  }

  Future<Map<String, String>> getNewToken(String refreshToken) async {
    final response = await Dio().post(
      AppConstants.apiRefreshTokenUrl,
      data: {'refreshToken': refreshToken},
    );

    if (response.statusCode == 200) {
      return {
        'accessToken': response.data['data']['AccessToken'],
        'refreshToken': response.data['data']['RefreshToken'],
        'expiresIn': response.data['data']['ExpiresIn'].toString(),
      };
    } else {
      throw DioError(
        requestOptions: RequestOptions(path: '/refresh-token'),
        error: 'Token refresh failed',
      );
    }
  }
}
