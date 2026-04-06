import 'package:client/data/datasources/remote/api_client.dart';
import 'package:client/data/models/track.dart';
import 'package:dio/dio.dart';

class TrackApiService {
  final _dio = ApiClient.instance;

  Future<List<Track>> getTracks() async {
    try {
      final response = await _dio.get('/tracks');

      final List list = response.data['tracks'];

      return list.map((item) => Track.fromJson(item)).toList();
    } on DioException catch (e) {
      throw ApiClient.handleDioError(e);
    } catch (e) {
      throw Exception("error_unknown");
    }
  }
}
