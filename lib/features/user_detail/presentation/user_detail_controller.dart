import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../data/user_detail_repository.dart';

class UserDetailController with ChangeNotifier {
  final UserDetailRepository _repository = UserDetailRepository();

  User? _user;
  User? get user => _user;

  bool _isFavorited = false;
  bool get isFavorited => _isFavorited;

  Future<void> fetchUserDetail(String username) async {
    try {
      final data = await _repository.fetchUserDetail(username);
      _user = User.fromMap(data);
      _isFavorited = await _repository.isFavorited(username);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }

  Future<void> toggleFavorite() async {
    if (_user == null) return;
    if (_isFavorited) {
      await _repository.removeFavorite(_user!.username);
    } else {
      await _repository.addFavorite(_user!);
    }
    _isFavorited = !_isFavorited;
    notifyListeners();
  }
}
