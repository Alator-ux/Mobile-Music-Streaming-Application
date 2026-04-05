import 'package:client/extensions/context_extensions.dart';
import 'package:client/presentation/controllers/auth/signup_controller.dart';
import 'package:client/presentation/screens/home/home_screen.dart';
import 'package:client/presentation/states/auth_state.dart';
import 'package:client/presentation/widgets/auth_navigation_text.dart';
import 'package:client/presentation/widgets/custom_button.dart';
import 'package:client/presentation/widgets/custom_text_form_field.dart';
import 'package:client/presentation/widgets/hide_password_button.dart';
import 'package:client/utils/api_helpers.dart';
import 'package:client/utils/form_validators.dart';
import 'package:client/utils/messenger.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _controller = SignUpController();
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
        Messenger.showError(context, getLocalizedError(state.message, context));
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
                    context.l10n.header_signup,
                    style: theme.textTheme.headlineMedium,
                  ),
                  CustomTextFormField(
                    labelText: context.l10n.name_label,
                    controller: _controller.nameController,
                    validator: (value) =>
                        FormValidators.isEmpty(context, value),
                  ),
                  CustomTextFormField(
                    labelText: context.l10n.email_label,
                    controller: _controller.emailController,
                    validator: (value) =>
                        FormValidators.emailValidator(context, value),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _controller.passwordVisibility,
                    builder: (context, value, child) {
                      return CustomTextFormField(
                        labelText: context.l10n.password_label,
                        controller: _controller.passwordController,
                        isPasswordField: value,
                        suffixIcon: HidePasswordButton(
                          value: value,
                          onPressed: () => _controller.togglePasswordVisible(
                            _controller.passwordVisibility,
                          ),
                        ),
                        validator: (value) =>
                            FormValidators.passwordValidator(context, value),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _controller.isPasswordConfirmVisible,
                    builder: (context, value, child) {
                      return CustomTextFormField(
                        labelText: context.l10n.password_confirm_label,
                        controller: _controller.passwordConfirmController,
                        isPasswordField: value,
                        suffixIcon: HidePasswordButton(
                          value: value,
                          onPressed: () => _controller.togglePasswordVisible(
                            _controller.isPasswordConfirmVisible,
                          ),
                        ),
                        validator: (value) =>
                            FormValidators.passwordConfirmValidator(
                              context,
                              value,
                              _controller.passwordController.text,
                            ),
                      );
                    },
                  ),
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (BuildContext context, Widget? child) {
                      final buttonContent = _controller.isLoading
                          ? const CustomButtonContent.loading()
                          : CustomButtonContent.text(
                              context.l10n.button_signup,
                            );
                      return CustomButton(
                        content: buttonContent,
                        onPressed: () async =>
                            await _controller.signUp(_formKey),
                      );
                    },
                  ),
                  AuthNavigationText(
                    questionText: context.l10n.already_have_account,
                    actionText: context.l10n.button_login,
                    onPressed: () {
                      Navigator.pop(context);
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
