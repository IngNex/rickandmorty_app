// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/ui/screens/home/widget/bottonTitle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonText(
            tap: () {
              context.go('/home/characters');
            },
            text: 'Characters',
          ),
          ButtonText(
            tap: () {
              context.go('/home/episodes');
            },
            text: 'Episodes',
          ),
          ButtonText(
            tap: () {
              context.go('/home/search_character');
            },
            text: 'Search Character',
          ),
        ],
      )),
    );
  }
}
