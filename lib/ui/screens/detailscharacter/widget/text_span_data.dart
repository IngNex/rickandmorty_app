import 'package:flutter/material.dart';

class TextSpanData extends StatelessWidget {
  const TextSpanData({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      text: TextSpan(
        text: title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, height: 1.2),
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
