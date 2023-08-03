part of 'search_character_bloc.dart';

abstract class SearchCharacterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSearchCharacterEvent extends SearchCharacterEvent {
  final String query;
  GetSearchCharacterEvent({
    required this.query,
  });
}
