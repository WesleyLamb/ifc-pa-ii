import 'package:flutter/material.dart';

class TextInputFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final String? label;
  final ValueChanged<String>? onChanged;

  const TextInputFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    InputDecoration? inputDecoration = (label == null
        ? null
        : InputDecoration(label: Text(label ?? '')));

    return TextFormField(
      keyboardType: keyboardType,
      autocorrect: true,
      decoration: inputDecoration,
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
