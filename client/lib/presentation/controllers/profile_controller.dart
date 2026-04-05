import 'package:client/data/datasources/local/auth_storage.dart';
import 'package:client/data/models/user.dart';
import 'package:flutter/cupertino.dart';

class ProfileController extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = true;

  User? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  final AuthStorage _storage = AuthStorage();

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _storage.getUser();

    _isLoading = false;
    notifyListeners();
  }

  void updateUserData(User newUser) {
    _currentUser = newUser;
    notifyListeners();
  }
}
