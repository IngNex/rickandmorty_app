import 'package:flutter/material.dart';
import 'package:rickandmorty/ui/widgets/bottom_pop.dart';

class AppBarImage extends StatelessWidget {
  const AppBarImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.black,
          ),
          child: const Image(
            image: AssetImage('assets/gif/rickandmorty.gif'),
          ),
        ),
        const Positioned(top: 30, left: 3, child: BottomPop())
      ],
    );
  }
}
