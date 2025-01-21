import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Response> getUsers(int page, int results) async {
    try {
      final response = await _dio.get(
        ApiConstants.baseUrl,
        queryParameters: {
          'page': page,
          'results': results,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
