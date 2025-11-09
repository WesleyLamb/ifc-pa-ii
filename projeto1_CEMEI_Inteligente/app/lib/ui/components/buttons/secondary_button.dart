import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        ),
        side: WidgetStateProperty.all(
          BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      onPressed: onPressed ?? () {},
      child: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
