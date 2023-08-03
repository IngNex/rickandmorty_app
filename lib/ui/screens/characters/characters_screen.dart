// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rickandmorty/bloc/characters/characters_bloc.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/ui/widgets/bottom_pop.dart';
import 'package:rickandmorty/ui/widgets/loading_widget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll)) {
      context.read<CharactersBloc>().add(GetCharactersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Stack(
              children: [
                Image(image: AssetImage('assets/gif/rickandmorty.gif')),
                Positioned(top: 5, left: 3, child: BottomPop())
              ],
            ),
            Expanded(
              child: BlocBuilder<CharactersBloc, CharactersState>(
                builder: (context, state) {
                  switch (state.status) {
                    case CharactersStatus.loading:
                      return const LoadingWidget();
                    case CharactersStatus.success:
                      if (state.posts.isEmpty) {
                        return const Center(
                          child: Text("No Characters"),
                        );
                      }
                      return GridView.builder(
                        itemCount: state.hasReachedMax
                            ? state.posts.length
                            : state.posts.length + 1,
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.posts.length
                              ? const LoadingWidget()
                              : CharacterItem(
                                  character: state.posts[index],
                                );
                        },
                      );

                    case CharactersStatus.error:
                      return Center(child: Text(state.errorMessage));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    Key? key,
    required this.character,
  }) : super(key: key);
  final Character character;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/home/characters/details', extra: character),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: character.status == 'Dead'
                                ? Colors.red
                                : character.status == 'Alive'
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      character.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Hero(
                tag: character.id!,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(character.image!),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
