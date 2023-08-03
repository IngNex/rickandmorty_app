import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rickandmorty/bloc/characters/characters_bloc.dart';
import 'package:rickandmorty/bloc/search_character/search_character_bloc.dart';
import 'package:rickandmorty/ui/screens/searchcharacter/widget/listtitle_character_item.dart';
import 'package:rickandmorty/ui/screens/searchcharacter/widget/search_delegate.dart';
import 'package:rickandmorty/ui/widgets/loading_widget.dart';

class SearchCharacterScreen extends StatefulWidget {
  const SearchCharacterScreen({super.key});

  @override
  State<SearchCharacterScreen> createState() => _SearchCharacterScreenState();
}

class _SearchCharacterScreenState extends State<SearchCharacterScreen> {
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
    if (currentScroll >= (maxScroll * 0.8)) {
      context.read<CharactersBloc>().add(GetCharactersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Character'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: SearchCharacter(
                      searchBloc: context.read<SearchCharacterBloc>(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    border: Border.all(width: 2, color: Colors.grey.shade600),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Text('Search Character...'),
                    ],
                  ),
                ),
              ),
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
                      return ListView.builder(
                        itemCount: state.hasReachedMax
                            ? state.posts.length
                            : state.posts.length + 1,
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.posts.length
                              ? const LoadingWidget()
                              : ListTitleCharacterItem(
                                  character: state.posts[index]);
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
