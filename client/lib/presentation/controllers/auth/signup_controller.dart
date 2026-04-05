import 'package:client/data/datasources/remote/auth_api_service.dart';
import 'package:client/presentation/controllers/auth/auth_base.dart';
import 'package:client/presentation/states/auth_state.dart';
import 'package:flutter/cupertino.dart';

class SignUpController extends ChangeNotifier with AuthBaseController {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  TextEditingController get nameController => _nameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get passwordConfirmController =>
      _passwordConfirmController;

  final ValueNotifier<bool> isPasswordConfirmVisible = ValueNotifier<bool>(
    true,
  );

  final _apiService = AuthApiService();

  Future<void> signUp(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        updateState(const AuthLoading());

        await _apiService.signUp(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final authData = await _apiService.signIn(
          username: _emailController.text.trim(),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    isPasswordConfirmVisible.dispose();

    disposeBase();
    super.dispose();
  }
}
