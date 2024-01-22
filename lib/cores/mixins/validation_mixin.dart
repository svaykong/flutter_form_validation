import 'package:email_validator/email_validator.dart';

mixin class ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }

    if (!EmailValidator.validate(value)) {
      return "Please enter valid email";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }
}
