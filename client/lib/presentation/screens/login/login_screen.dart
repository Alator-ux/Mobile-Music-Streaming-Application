import 'package:client/extensions/context_extensions.dart';
import 'package:client/presentation/controllers/auth/login_controller.dart';
import 'package:client/presentation/screens/home/home_screen.dart';
import 'package:client/presentation/screens/sign_up/signup_screen.dart';
import 'package:client/presentation/states/auth_state.dart';
import 'package:client/presentation/widgets/auth_navigation_text.dart';
import 'package:client/presentation/widgets/custom_button.dart';
import 'package:client/presentation/widgets/custom_text_form_field.dart';
import 'package:client/presentation/widgets/hide_password_button.dart';
import 'package:client/utils/form_validators.dart';
import 'package:client/utils/messenger.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = LoginController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.addListener(() {
      final state = _controller.state;
      if (state is AuthSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
      }
      if (state is AuthError) {
        Messenger.showError(context, state.message);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: 370,
              child: Column(
                spacing: 10,
                mainAxisAlignment: .center,
                children: [
                  Text(
                    context.l10n.header_login,
                    style: theme.textTheme.headlineMedium,
                  ),
                  CustomTextFormField(
                    labelText: context.l10n.login_label,
                    controller: _controller.loginController,
                    validator: (value) =>
                        FormValidators.isEmpty(context, value),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _controller.passwordVisibility,
                    builder: (_, value, _) {
                      return CustomTextFormField(
                        controller: _controller.passwordController,
                        validator: (value) =>
                            FormValidators.isEmpty(context, value),
                        isPasswordField: value,
                        labelText: context.l10n.password_label,
                        suffixIcon: HidePasswordButton(
                          value: value,
                          onPressed: () => _controller.togglePasswordVisible(
                            _controller.passwordVisibility,
                          ),
                        ),
                      );
                    },
                  ),
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (_, _) {
                      final buttonContent = _controller.isLoading
                          ? const CustomButtonContent.loading()
                          : CustomButtonContent.text(
                              context.l10n.button_submit,
                            );
                      return CustomButton(
                        content: buttonContent,
                        onPressed: () async =>
                            await _controller.login(_formKey),
                      );
                    },
                  ),
                  AuthNavigationText(
                    questionText: context.l10n.no_account,
                    actionText: context.l10n.button_signup,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
