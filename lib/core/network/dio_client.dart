import 'package:dio/dio.dart';
import 'package:mush_room/core/environments/config_manager.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio(
    BaseOptions(
      baseUrl: ConfigManager.config.apiBaseUrl,
      connectTimeout: ConfigManager.config.connectTimeout,
      receiveTimeout: ConfigManager.config.receiveTimeout,
    ),
  );

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    return _dio.delete(path, data: data);
  }
}