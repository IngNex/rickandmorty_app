import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bloc/characters/characters_bloc.dart';
import 'package:rickandmorty/ui/screens/characters/widget/character_item.dart';
import 'package:rickandmorty/ui/widgets/animation_translate.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          AnimationTranslate(
            top: false,
            child: Stack(
              children: [
                Container(
                  width: size.width,
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
            ),
          ),
          Expanded(
            child: AnimationTranslate(
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
                            : state.posts.length + 2,
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
          ),
        ],
      ),
    );
  }
}