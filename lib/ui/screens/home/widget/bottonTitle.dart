import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    required this.tap,
    required this.text,
  }) : super(key: key);

  final VoidCallback tap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
