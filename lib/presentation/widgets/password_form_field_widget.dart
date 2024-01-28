import 'package:flutter/material.dart';

import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class PasswordFormFieldWidget extends StatefulWidget {
  const PasswordFormFieldWidget({
    super.key,
    required this.passwordCtr,
  });

  final TextEditingController passwordCtr;

  @override
  State<PasswordFormFieldWidget> createState() => _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  /// This EmailFocusNode, PasswordFocusNode instance hold focus state
  final passwordFocusNode = FocusNode();

  /// This obscure holds status of show & hide secret password
  bool obscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    /// remove PasswordFocusNode instance when stop use it. (save memory, optimize app)
    passwordFocusNode.dispose();

    /// if no longer use remove it
    Provider.of(context).bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context).bloc;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) => TextFormField(
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: passwordFocusNode,
          obscureText: obscure,
          decoration: InputDecoration(
            errorText: snapshot.error?.toString(),
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
            bloc.changePassword(value);
          },
          onTapOutside: (event) {
            /// invoke PasswordFocusNode to stop focus (unfocus)
            if (passwordFocusNode.hasFocus) {
              passwordFocusNode.unfocus();
            }
          },
        ),
      ),
    );
  }
}
