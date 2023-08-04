part of 'charac_episode_bloc.dart';

abstract class CharacterEpisodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCharacterEpisodeEvent extends CharacterEpisodeEvent {
  final Character character;
  GetCharacterEpisodeEvent({
    required this.character,
  });
}
