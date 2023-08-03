part of 'characters_bloc.dart';

enum CharactersStatus { loading, success, error }

class CharactersState extends Equatable {
  final CharactersStatus status;
  final List<Character> posts;
  final bool hasReachedMax;
  final String errorMessage;

  const CharactersState(
      {this.status = CharactersStatus.loading,
      this.hasReachedMax = false,
      this.posts = const [],
      this.errorMessage = ""});

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? posts,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return CharactersState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax, errorMessage];
}
