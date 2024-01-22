import 'package:flutter/material.dart';
import '../../cores/mixins/validation_mixin.dart';

class PasswordFormFieldWidget extends StatefulWidget {
  const PasswordFormFieldWidget({
    super.key,
    required this.passwordCtr,
  });

  final TextEditingController passwordCtr;

  @override
  State<PasswordFormFieldWidget> createState() => _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> with ValidationMixin {
  /// This EmailFocusNode, PasswordFocusNode instance hold focus state
  final passwordFocusNode = FocusNode();

  /// This obscure holds status of show & hide secret password
  bool obscure = true;

  @override
  void dispose() {
    super.dispose();

    /// remove PasswordFocusNode instance when stop use it. (save memory, optimize app)
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: passwordFocusNode,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
            onPressed: () {
              setState(() {
                /// exchange the value everytime it pressed
                obscure = !obscure;
              });
            },
          ),
          prefixIcon: const Icon(Icons.key),
          labelText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onChanged: (value) {
          setState(() {
            widget.passwordCtr.text = value;
          });
        },
        onTapOutside: (event) {
          /// invoke PasswordFocusNode to stop focus (unfocus)
          if (passwordFocusNode.hasFocus) {
            passwordFocusNode.unfocus();
          }
        },
        validator: validatePassword,
      ),
    );
  }
}
