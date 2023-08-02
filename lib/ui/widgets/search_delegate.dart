import 'package:flutter/material.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/providers/api_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchCharacter extends SearchDelegate {
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
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = Provider.of<ApiProvider>(context);

    Widget CircleLoading() {
      return const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/gif/upload.gif'),
        ),
      );
    }

    if (query.isEmpty) {
      return CircleLoading();
    }

    return FutureBuilder(
      future: characterProvider.getCharater(query),
      builder: (context, AsyncSnapshot<List<Character>> snapshot) {
        if (!snapshot.hasData) {
          return CircleLoading();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final character = snapshot.data![index];
            return ListTile(
              onTap: () {
                context.go('/character', extra: character);
              },
              title: Text(character.name!),
              leading: CircleAvatar(
                child: Image(image: NetworkImage(character.image!)),
              ),
            );
          },
        );
      },
    );
  }
}
