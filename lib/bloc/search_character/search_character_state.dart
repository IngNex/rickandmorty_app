part of 'search_character_bloc.dart';

enum SearchCharacterStatus { loading, success, error }

class SearchCharacterState extends Equatable {
  final SearchCharacterStatus status;
  final List<Character> posts;
  final String query;
  final bool hasReachedMax;
  final String errorMessage;

  const SearchCharacterState(
      {this.status = SearchCharacterStatus.loading,
      this.hasReachedMax = false,
      this.query = '',
      this.posts = const [],
      this.errorMessage = ""});

  SearchCharacterState copyWith({
    SearchCharacterStatus? status,
    List<Character>? posts,
    String? query,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return SearchCharacterState(
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
