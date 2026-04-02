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

  Future<void> signUp(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        updateState(AuthLoading());
        await Future.delayed(Duration(seconds: 2));
        updateState(AuthSuccess());
      } catch (e) {
        //serverError =
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    isPasswordConfirmVisible.dispose();

    disposeBase();
    super.dispose();
  }
}
