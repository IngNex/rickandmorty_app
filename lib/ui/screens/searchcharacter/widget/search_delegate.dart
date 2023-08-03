import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bloc/search_character/search_character_bloc.dart';
import 'package:rickandmorty/ui/widgets/loading_widget.dart';

import 'listtitle_character_item.dart';

class SearchCharacter extends SearchDelegate<List> {
  SearchCharacter({required this.searchBloc});
  SearchCharacterBloc searchBloc;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, [null]);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(GetSearchCharacterEvent(query: query));
    Widget CircleLoading() {
      return const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/gif/upload.gif'),
        ),
      );
    }

    return BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchCharacterStatus.loading:
            return const LoadingWidget();
          case SearchCharacterStatus.success:
            if (state.posts.isEmpty) {
              return const Center(
                child: Text("No Characters"),
              );
            }
            return ListView.builder(
              itemCount: state.posts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final character = state.posts[index];
                return ListTitleCharacterItem(character: character);
              },
            );

          case SearchCharacterStatus.error:
            return Center(child: Text(state.errorMessage));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
