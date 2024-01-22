import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/email_form_field_widget.dart';
import '../widgets/password_form_field_widget.dart';
import '../widgets/button_widget.dart';
import '../../cores/mixins/validation_mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  /// This EmailController, PasswordController hold value of TextField
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// This global form key holds state checking, validating
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    /// remove EmailController, PasswordController instance when stop use it. (save memory, optimize app)
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Login In',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Please fill your information',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(36.0),
              EmailFormFieldWidget(emailCtr: emailController),
              PasswordFormFieldWidget(passwordCtr: passwordController),
              ButtonWidget(
                title: 'Submit',
                onPressed: () {
                  /// validate form's TextField with formKey
                  bool validate = formKey.currentState?.validate() ?? false;
                  if (validate) {
                    /// if the Form is valid then processing app to the next screen
                    /// Retrieve the TextField values
                    if (kDebugMode) {
                      print('input email text: ${emailController.text}');
                      print('input password text: ${passwordController.text}');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
