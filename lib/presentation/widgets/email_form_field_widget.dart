import 'package:flutter/material.dart';

import '../../presentation/blocs/bloc.dart';
import '../blocs/provider.dart';

/// TextFormField:
/// Source of events
/// onChanged: sink
///
/// Input data stream from a widget -> BLOC -> Output data stream to a widget
class EmailFormFieldWidget extends StatefulWidget {
  const EmailFormFieldWidget({
    super.key,
    required this.emailCtr,
  });

  final TextEditingController emailCtr;

  @override
  State<EmailFormFieldWidget> createState() => _EmailFormFieldWidgetState();
}

class _EmailFormFieldWidgetState extends State<EmailFormFieldWidget> {
  /// This EmailFocusNode instance hold focus state
  final emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    /// add listener: onListen
    widget.emailCtr.addListener(onListen);
  }

  @override
  void dispose() {
    /// remove EmailFocusNode instance when stop use it. (save memory, optimize app)
    emailFocusNode.dispose();

    /// remove listener: onListen
    widget.emailCtr.removeListener(onListen);

    /// if no longer use remove it
    Provider.of(context).bloc.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context).bloc;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder(
          stream: bloc.email,
          builder: (context, snapshot) {
            return TextFormField(
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
                errorText: snapshot.error?.toString(),
                prefixIcon: const Icon(Icons.email),
                suffixIcon: widget.emailCtr.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          widget.emailCtr.clear();
                          bloc.changeEmail('');
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
                bloc.changeEmail(value);
              },
            );
          }),
    );
  }
}
