import 'package:client/data/datasources/local/auth_storage.dart';
import 'package:client/data/models/user.dart';
import 'package:client/presentation/states/auth_state.dart';
import 'package:flutter/cupertino.dart';

mixin AuthBaseController on ChangeNotifier {
  AuthState _state = const AuthIdle();

  AuthState get state => _state;

  final ValueNotifier<bool> passwordVisibility = ValueNotifier<bool>(true);

  bool get isLoading => _state is AuthLoading;

  void togglePasswordVisible(ValueNotifier<bool> notifier) {
    notifier.value = !notifier.value;
  }

  final _storage = AuthStorage();

  Future<void> saveSession(Map<String, dynamic> authData) async {
    final String token = authData['token'];
    final User user = authData['user'];

    await _storage.saveToken(token);
    await _storage.saveUser(user);
  }

  void updateState(AuthState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  void disposeBase() {
    passwordVisibility.dispose();
  }
}
