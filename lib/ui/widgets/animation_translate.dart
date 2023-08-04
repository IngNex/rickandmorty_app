import 'package:flutter/material.dart';

class AnimationTranslate extends StatelessWidget {
  const AnimationTranslate({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.offset = 120.0,
    this.curve = Curves.easeInOutBack,
    this.top = true,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final double offset;
  final Curve curve;
  final bool top;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 1.0, end: 0.0),
      child: child,
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: top ? Offset(0, offset * value) : Offset(0, -offset * value),
          child: child,
        );
      },
    );
  }
}
