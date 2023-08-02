// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/providers/api_bloc.dart';
import 'package:provider/provider.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({
    Key? key,
    required this.character,
  }) : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(character.name!)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                tag: character.id!,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(character.image!),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: size.height * 0.14,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardData("Status", character.status!),
                  CardData("Species", character.species!),
                  CardData("Origin", character.origin!.name!),
                ],
              ),
            ),
            const Text(
              'Episodes',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            EpisodeList(size: size, character: character)
          ],
        ),
      ),
    );
  }
}

Widget CardData(String text1, String text2) {
  return Expanded(
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text1),
          Text(
            text2,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ),
  );
}

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    Key? key,
    required this.size,
    required this.character,
  }) : super(key: key);
  final Size size;
  final Character character;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisodes(widget.character);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final episodes = apiProvider.episodes;
    return SizedBox(
      height: widget.size.height * 0.35,
      child: ListView.builder(
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(episodes[index].episode!),
            title: Text(episodes[index].name!),
            trailing: Text(episodes[index].airDate!),
          );
        },
      ),
    );
  }
}
