import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bloc/character/character_event.dart';
import 'package:rickandmorty/bloc/character/character_state.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/resource/api_repository.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetCharacterList>((event, emit) async {
      try {
        emit(CharacterLoading());
        List<Character> characterList =
            await apiRepository.getCharacters(event.page);
        emit(CharacterLoaded(characterList: characterList));
        if (characterList[0].error != null) {
          emit(CharacterError(error: characterList[0].error));
        }
      } on NetworkError {
        emit(const CharacterError(
            error: "Failed to fetch is your device online"));
      }
    });
  }
}
