import 'package:flutter/material.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/ui/widgets/animation_translate.dart';

class AnimatedDisplacement extends StatefulWidget {
  const AnimatedDisplacement({
    Key? key,
    required this.character,
  }) : super(key: key);
  final Character character;
  @override
  State<AnimatedDisplacement> createState() => _AnimatedDisplacementState();
}

class _AnimatedDisplacementState extends State<AnimatedDisplacement>
    with SingleTickerProviderStateMixin {
  final _displacement = -50.0;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              left: _displacement * _controller.value,
              right: _displacement * (1 - _controller.value),
              child: Hero(
                tag: widget.character.id!,
                child: Image(
                  image: NetworkImage(widget.character.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 150,
              bottom: -15,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.greenAccent.shade400],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: 100 * _controller.value,
              right: 100 * (1 - _controller.value),
              child: AnimationTranslate(
                top: false,
                child: Text(
                  widget.character.name!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 3, color: Colors.grey)],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
