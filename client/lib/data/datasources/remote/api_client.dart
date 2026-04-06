import 'package:dio/dio.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:9000",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  static Dio get instance => _dio;

  static Exception handleDioError(DioException e) {
    if (e.response != null) {
      final status = e.response!.statusCode;
      final data = e.response!.data;

      final String serverDetail = (data is Map && data.containsKey('detail'))
          ? data['detail'].toString()
          : "error_status_$status";

      switch (status) {
        case 400:
          return Exception(serverDetail);
        case 401:
          return Exception("error_unauthorized");
        case 500:
          return Exception("error_server_internal");
        default:
          return Exception(serverDetail);
      }
    }

    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception("error_timeout");
    }
    return Exception("error_no_internet");
  }
}
