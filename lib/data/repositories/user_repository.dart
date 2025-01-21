import 'package:flutter_datingapp_restapi/core/api/api_client.dart';
import 'package:flutter_datingapp_restapi/core/constants/api_constants.dart';
import 'package:flutter_datingapp_restapi/data/models/user_model.dart';


class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<UserModel> getUsers(int page) async {
    final response = await _apiClient.getUsers(page, ApiConstants.pageSize);
    return UserModel.fromJson(response.data);
  }
}
