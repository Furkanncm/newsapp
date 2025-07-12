import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    required this.emailController,
    super.key,
  });

  final TextEditingController emailController;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late final TextEditingController _emailController;

  late ValueNotifier<String?> inputText;
  @override
  void initState() {
    _emailController = widget.emailController;
    inputText = ValueNotifier(widget.emailController.text);

    _emailController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LuciEmailTextFormField(
      controller: _emailController,
      labelText: '',
      suffixIcon: ValueListenableBuilder<String?>(
        valueListenable: inputText,
        builder: (context, value, child) {
          return _emailController.text.isEmpty
              ? emptyBox
              : IconButton(
                  icon: const Icon(Icons.clear_outlined),
                  onPressed: () {
                    _emailController.clear();
                  },
                );
        },
      ),
    );
  }
}
