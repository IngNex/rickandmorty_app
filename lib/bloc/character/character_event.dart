// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent(
    this.page,
  );
  @override
  List<Object> get props => [];
  final int page;
}

class GetCharacterList extends CharacterEvent {
  const GetCharacterList(super.page);
}
