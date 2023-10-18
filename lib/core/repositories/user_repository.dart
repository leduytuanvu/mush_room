import 'package:dio/dio.dart';
import 'package:mush_room/core/models/user/user_model.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<UserModel> getUser() async {
    // Assuming you have an endpoint to get the user data.
    final response = await _dioClient.dio.get('/user');
    return UserModel.fromJson(response.data);
  }

  Future<void> saveUser(UserModel user) async {
    // Assuming you store user data in SharedPreferences.
    // await _sharedPreferenceService.setString('user', user.toJson());
  }

  Future<void> deleteUser() async {
    // Assuming you delete user data from SharedPreferences.
    // await _sharedPreferenceService.remove('user');
  }
}
