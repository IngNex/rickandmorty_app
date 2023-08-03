part of 'episodes_bloc.dart';

enum EpisodesStatus { loading, success, error }

class EpisodesState extends Equatable {
  final EpisodesStatus status;
  final List<Episode> posts;
  final bool hasReachedMax;
  final String errorMessage;

  const EpisodesState(
      {this.status = EpisodesStatus.loading,
      this.hasReachedMax = false,
      this.posts = const [],
      this.errorMessage = ""});

  EpisodesState copyWith({
    EpisodesStatus? status,
    List<Episode>? posts,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return EpisodesState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax, errorMessage];
}
