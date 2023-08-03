import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/domain/models/episode_models.dart';
import 'package:rickandmorty/resource/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<Character>> getCharacters(int page) {
    return _apiProvider.getCharacters(page);
  }

  Future<List<Episode>> getEpisodes(int page) {
    return _apiProvider.getEpisodes(page);
  }

  Future<List<Character>> getSearchCharacter(String query) {
    return _apiProvider.getSearchCharacter(query);
  }
}

class NetworkError extends Error {}
