import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'validators.dart';

class Bloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  /// Retrieve data from stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) => true);

  /// Add data to stream
  void Function(String) get changeEmail => _emailController.sink.add;

  void Function(String) get changePassword => _passwordController.sink.add;

  void submit(BuildContext context) {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    if (validateEmail.toString().isNotEmpty && validatePassword.toString().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing...'),
        ),
      );
    }
  }

  void dispose() {
    if (_emailController.isClosed == false) _emailController.close();
    if (_passwordController.isClosed == false) _passwordController.close();
  }
}
