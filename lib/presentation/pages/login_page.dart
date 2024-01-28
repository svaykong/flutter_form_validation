import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../blocs/bloc.dart';
import '../blocs/provider.dart';
import '../widgets/email_form_field_widget.dart';
import '../widgets/password_form_field_widget.dart';
import '../widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// This EmailController, PasswordController hold value of TextField
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    /// remove EmailController, PasswordController instance when stop use it. (save memory, optimize app)
    emailController.dispose();
    passwordController.dispose();

    /// if no longer use remove it
    Provider.of(context).bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context).bloc;
    return Scaffold(
      body: SafeArea(
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
            StreamBuilder(
              stream: bloc.submitValid,
              builder: (context, snapshot) => ButtonWidget(
                title: 'Submit',
                disableColor: Colors.lightBlueAccent,
                onPressed: snapshot.hasData ? () => bloc.submit(context) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
