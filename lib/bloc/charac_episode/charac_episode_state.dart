part of 'charac_episode_bloc.dart';

enum CharacterEpisodeStatus { loading, success, error }

class CharacterEpisodeState extends Equatable {
  final CharacterEpisodeStatus status;
  final List<Episode> posts;
  final String query;
  final bool hasReachedMax;
  final String errorMessage;

  const CharacterEpisodeState(
      {this.status = CharacterEpisodeStatus.loading,
      this.hasReachedMax = false,
      this.query = '',
      this.posts = const [],
      this.errorMessage = ""});

  CharacterEpisodeState copyWith({
    CharacterEpisodeStatus? status,
    List<Episode>? posts,
    String? query,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return CharacterEpisodeState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      query: query ?? this.query,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, posts, query, hasReachedMax, errorMessage];
}
