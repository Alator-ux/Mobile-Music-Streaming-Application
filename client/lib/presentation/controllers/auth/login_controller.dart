import 'package:client/data/datasources/remote/auth_api_service.dart';
import 'package:client/presentation/controllers/auth/auth_base.dart';
import 'package:client/presentation/states/auth_state.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier with AuthBaseController {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get loginController => _loginController;

  TextEditingController get passwordController => _passwordController;

  final _apiService = AuthApiService();

  Future<void> login(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        updateState(const AuthLoading());

        final authData = await _apiService.signIn(
          username: _loginController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await saveSession(authData);

        updateState(const AuthSuccess());
      } catch (e) {
        updateState(AuthError(e.toString().replaceAll('Exception: ', '')));
      } finally {
        if (state is AuthError) {
          updateState(const AuthIdle());
        }
      }
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    disposeBase();
    super.dispose();
  }
}
