import 'package:flutter/material.dart';

class PasswordInputFormField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const PasswordInputFormField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(label: Text('Senha')),
      onChanged: onChanged,
    );
  }

  // TextFormField(
  //   keyboardType: TextInputType.emailAddress,
  //   autocorrect: true,
  //   decoration: const InputDecoration(label: Text('E-mail')),
  //   onChanged: (value) => {
  //     setState(() {
  //       _email = value;
  //     }),
  //   },
  // ),
}
