import 'package:dio/dio.dart';
import '../../../database/database_helper.dart';
import '../../../models/user_model.dart';

class UserDetailRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchUserDetail(String username) async {
    final String url = 'https://api.github.com/users/$username';
    try {
      final response = await _dio.get(url);
      return response.data;
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }

  Future<bool> isFavorited(String username) async {
    final users = await DatabaseHelper().getAllUsers();
    return users.any((user) => user.username == username);
  }

  Future<void> addFavorite(User user) async {
    await DatabaseHelper().insertUser(user);
  }

  Future<void> removeFavorite(String username) async {
    final users = await DatabaseHelper().getAllUsers();
    final user = users.firstWhere((user) => user.username == username);
    await DatabaseHelper().deleteUser(user.id!);
  }
}
