import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/resource/api_repository.dart';
import 'package:rickandmorty/domain/models/character_models.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(const CharactersState()) {
    final ApiRepository apiRepository = ApiRepository();
    int page = 1;
    on<CharactersEvent>((event, emit) async {
      if (event is GetCharactersEvent) {
        if (state.hasReachedMax) return;

        try {
          if (state.status == CharactersStatus.loading) {
            final posts = await apiRepository.getCharacters(page);
            return posts.isEmpty
                ? emit(state.copyWith(
                    status: CharactersStatus.success, hasReachedMax: true))
                : emit(state.copyWith(
                    status: CharactersStatus.success,
                    posts: posts,
                    hasReachedMax: false));
          } else {
            page++;
            final posts = await apiRepository.getCharacters(page);
            posts.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(
                    state.copyWith(
                        status: CharactersStatus.success,
                        posts: List.of(state.posts)..addAll(posts),
                        hasReachedMax: false),
                  );
          }
        } catch (e) {
          emit(
            state.copyWith(
                status: CharactersStatus.success, hasReachedMax: true),
          );
        }
      }
    }, transformer: droppable());
  }
}
