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

  void updateState(AuthState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  void disposeBase() {
    passwordVisibility.dispose();
  }
}
