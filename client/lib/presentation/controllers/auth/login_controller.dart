import 'package:client/presentation/controllers/auth/auth_base.dart';
import 'package:client/presentation/states/auth_state.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier with AuthBaseController {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get loginController => _loginController;

  TextEditingController get passwordController => _passwordController;

  Future<void> login(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        updateState(const AuthLoading());
        await Future.delayed(Duration(seconds: 2));
        //тут сохраняем юзера и JWT
        updateState(const AuthSuccess());
      } catch (e) {
        //тут типа приходит ошибка, маппим ее и сохраняем в текст ошибки:
        //serverError = mapServerError();
        updateState(AuthError(e.toString()));
      } finally {
        if (state is AuthError) {
          updateState(AuthIdle());
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
