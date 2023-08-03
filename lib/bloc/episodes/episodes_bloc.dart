import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/resource/api_repository.dart';
import 'package:rickandmorty/domain/models/episode_models.dart';
part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  EpisodesBloc() : super(const EpisodesState()) {
    final ApiRepository apiRepository = ApiRepository();
    int page = 1;
    on<EpisodesEvent>((event, emit) async {
      if (event is GetEpisodesEvent) {
        if (state.hasReachedMax) return;

        try {
          if (state.status == EpisodesStatus.loading) {
            final posts = await apiRepository.getEpisodes(page);
            return posts.isEmpty
                ? emit(state.copyWith(
                    status: EpisodesStatus.success, hasReachedMax: true))
                : emit(state.copyWith(
                    status: EpisodesStatus.success,
                    posts: posts,
                    hasReachedMax: false));
          } else {
            page++;
            final posts = await apiRepository.getEpisodes(page);
            posts.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(
                    state.copyWith(
                        status: EpisodesStatus.success,
                        posts: List.of(state.posts)..addAll(posts),
                        hasReachedMax: false),
                  );
          }
        } catch (e) {
          emit(
            state.copyWith(status: EpisodesStatus.success, hasReachedMax: true),
          );
        }
      }
    }, transformer: droppable());
  }
}
