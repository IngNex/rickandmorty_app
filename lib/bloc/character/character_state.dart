import 'package:equatable/equatable.dart';
import 'package:rickandmorty/domain/models/character_models.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characterList;
  const CharacterLoaded({required this.characterList});
}

class CharacterError extends CharacterState {
  final String? error;
  const CharacterError({required this.error});
}
