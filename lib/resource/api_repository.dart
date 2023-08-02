import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/resource/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<Character>> getCharacters(int page) {
    return _apiProvider.getCharacters(page);
  }
}

class NetworkError extends Error {}
