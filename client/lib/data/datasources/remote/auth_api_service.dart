import 'package:client/data/datasources/remote/api_client.dart';
import 'package:client/data/models/user.dart';
import 'package:dio/dio.dart';

class AuthApiService {
  final Dio _dio = ApiClient.instance;

  Future<Map<String, dynamic>> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await _dio.post('/login', data: formData);
      return {
        'token': response.data['access_token'],
        'user': User.fromJson(response.data['user']),
      };
    } on DioException catch (e) {
      throw ApiClient.handleDioError(e);
    } catch (e) {
      throw Exception("error_unknown");
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _dio.post(
        '/register',
        data: {"name": name, "email": email, "password": password},
      );
    } on DioException catch (e) {
      throw ApiClient.handleDioError(e);
    } catch (e) {
      throw Exception("error_unknown");
    }
  }
}
