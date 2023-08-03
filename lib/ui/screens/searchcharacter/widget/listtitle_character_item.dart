import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/domain/models/character_models.dart';

class ListTitleCharacterItem extends StatelessWidget {
  const ListTitleCharacterItem({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          context.go('/home/search_character/details', extra: character);
        },
        title: Text(character.name!),
        leading: Hero(
          tag: character.id!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
              placeholder: const AssetImage('assets/gif/upload.gif'),
              image: NetworkImage(character.image!),
            ),
          ),
        ),
        trailing: Container(
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
      ),
    );
  }
}
