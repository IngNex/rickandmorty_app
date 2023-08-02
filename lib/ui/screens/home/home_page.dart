import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/bloc/character/character_event.dart';
import 'package:rickandmorty/bloc/character/character_state.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/resource/api_provider.dart';

import '../../../bloc/character/character_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  final CharacterBloc _characterBloc = CharacterBloc();
  @override
  void initState() {
    super.initState();
    _characterBloc.add(GetCharacterList(page));

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });

        page++;
        _characterBloc.add(GetCharacterList(page));
        setState(() {
          isLoading = false;
        });
      } else if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        setState(() {
          isLoading = true;
        });

        page--;
        _characterBloc.add(GetCharacterList(page));
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (context) => _characterBloc,
              child: BlocBuilder<CharacterBloc, CharacterState>(
                bloc: _characterBloc,
                builder: (context, state) {
                  if (state is CharacterError) {
                    Center(
                      child: Text(state.error!),
                    );
                  } else if (state is CharacterInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CharacterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CharacterLoaded) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: state.characterList.isNotEmpty
                          ? CharacterList(
                              character: state,
                              scrollController: scrollController,
                              isLoading: isLoading,
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({
    Key? key,
    required this.character,
    required this.scrollController,
    required this.isLoading,
  }) : super(key: key);

  final CharacterLoaded character;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final char = character.characterList;
    return GridView.builder(
      itemCount: isLoading ? char.length + 2 : char.length,
      controller: scrollController,
      physics: FixedExtentScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.87,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return index < char.length
            ? GestureDetector(
                onTap: () {
                  context.go('/character', extra: char[index]);
                },
                child: Card(
                  child: Column(
                    children: [
                      Hero(
                        tag: char[index].id!,
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/gif/upload.gif'),
                          image: NetworkImage(char[index].image!),
                        ),
                      ),
                      Text(
                        char[index].name!,
                        style: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
