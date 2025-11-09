import 'package:flutter/widgets.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  const SubtitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
    );
  }
}
