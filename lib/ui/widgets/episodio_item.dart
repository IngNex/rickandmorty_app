import 'package:flutter/material.dart';
import 'package:rickandmorty/domain/models/episode_models.dart';

class EpisodeItem extends StatelessWidget {
  const EpisodeItem({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(child: Text(episode.id.toString())),
        title: Text(episode.name!),
        subtitle: Text(episode.airDate!),
        trailing: Text(episode.episode!),
      ),
    );
  }
}
