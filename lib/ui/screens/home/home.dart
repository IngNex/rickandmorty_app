// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/ui/screens/home/widget/bottonTitle.dart';
import 'package:rickandmorty/ui/widgets/animation_translate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/login');
        },
        elevation: 5,
        tooltip: 'Log out',
        backgroundColor: Colors.redAccent.shade200,
        child: const Icon(Icons.logout),
      ),
      body: SafeArea(
          child: Column(
        children: [
          AnimationTranslate(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.2,
              child: const Image(
                image: AssetImage('assets/name.png'),
              ),
            ),
          ),
          AnimationTranslate(
            duration: const Duration(milliseconds: 800),
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.42,
              child: const Image(
                image: AssetImage('assets/rickandmorty.png'),
              ),
            ),
          ),
          const AnimationTranslate(
            duration: Duration(milliseconds: 800),
            child: Text(
              'ApiRest Rick and Morty',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: AnimationTranslate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
