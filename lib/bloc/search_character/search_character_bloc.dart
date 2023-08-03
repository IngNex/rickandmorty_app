import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/resource/api_repository.dart';

part 'search_character_event.dart';
part 'search_character_state.dart';

class SearchCharacterBloc
    extends Bloc<SearchCharacterEvent, SearchCharacterState> {
  SearchCharacterBloc() : super(const SearchCharacterState()) {
    final ApiRepository apiRepository = ApiRepository();
    on<SearchCharacterEvent>((event, emit) async {
      if (event is GetSearchCharacterEvent) {
        if (state.hasReachedMax) return;

        try {
          final posts = await apiRepository.getSearchCharacter(event.query);

          return posts.isEmpty
              ? emit(state.copyWith(
                  status: SearchCharacterStatus.success, hasReachedMax: true))
              : emit(
                  state.copyWith(
                      status: SearchCharacterStatus.success,
                      posts: posts,
                      hasReachedMax: false),
                );
        } catch (e) {
          emit(
            state.copyWith(
                status: SearchCharacterStatus.loading, hasReachedMax: false),
          );
        }
      }
    }, transformer: droppable());
  }
}
