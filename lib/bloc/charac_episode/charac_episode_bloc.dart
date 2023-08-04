import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/domain/models/episode_models.dart';
import 'package:rickandmorty/resource/api_repository.dart';

part 'charac_episode_event.dart';
part 'charac_episode_state.dart';

class CharacterEpisodeBloc
    extends Bloc<CharacterEpisodeEvent, CharacterEpisodeState> {
  CharacterEpisodeBloc() : super(const CharacterEpisodeState()) {
    final ApiRepository apiRepository = ApiRepository();
    on<CharacterEpisodeEvent>((event, emit) async {
      if (event is GetCharacterEpisodeEvent) {
        try {
          final posts =
              await apiRepository.getEpisodesCharater(event.character);

          return posts.isEmpty
              ? emit(state.copyWith(
                  status: CharacterEpisodeStatus.success, hasReachedMax: true))
              : emit(
                  state.copyWith(
                      status: CharacterEpisodeStatus.success,
                      posts: posts,
                      hasReachedMax: false),
                );
        } catch (e) {
          emit(
            state.copyWith(
                status: CharacterEpisodeStatus.loading, hasReachedMax: false),
          );
        }
      }
    }, transformer: droppable());
  }
}
