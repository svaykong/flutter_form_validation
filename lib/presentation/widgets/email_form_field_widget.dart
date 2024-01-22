import 'package:flutter/material.dart';
import '../../cores/mixins/validation_mixin.dart';

class EmailFormFieldWidget extends StatefulWidget {
  const EmailFormFieldWidget({
    super.key,
    required this.emailCtr,
  });

  final TextEditingController emailCtr;

  @override
  State<EmailFormFieldWidget> createState() => _EmailFormFieldWidgetState();
}

class _EmailFormFieldWidgetState extends State<EmailFormFieldWidget> with ValidationMixin {
  /// This EmailFocusNode instance hold focus state
  final emailFocusNode = FocusNode();

  @override
  void initState() {
    /// add listener: onListen
    widget.emailCtr.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    /// remove EmailFocusNode instance when stop use it. (save memory, optimize app)
    emailFocusNode.dispose();

    /// remove listener: onListen
    widget.emailCtr.removeListener(onListen);
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: widget.emailCtr,
        autocorrect: false,
        autofillHints: const [
          AutofillHints.email,
        ],
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: emailFocusNode,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          suffixIcon: widget.emailCtr.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    widget.emailCtr.clear();
                  },
                ),
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onTapOutside: (event) {
          /// invoke EmailFocusNode to stop focus (unfocus)
          if (emailFocusNode.hasFocus) {
            emailFocusNode.unfocus();
          }
        },
        onChanged: (value) {
          setState(() {
            widget.emailCtr.text = value;
          });
        },
        validator: validateEmail,
      ),
    );
  }
}
