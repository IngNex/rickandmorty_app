import 'package:dio/dio.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/domain/models/episode_models.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final dio = Dio();
  final String url = 'https://rickandmortyapi.com/';
  Future<List<Character>> getCharacters([int page = 1]) async {
    try {
      Response result = await dio.get('$url/api/character?page=$page');
      List<dynamic> characters = result.data['results'];

      return characters.map((e) => Character.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Episode>> getEpisodes(int page) async {
    try {
      Response result =
          await dio.get('$url/api/episode', queryParameters: {'page': page});
      List<dynamic> characters = result.data['results'];

      return characters.map((e) => Episode.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Character>> getSearchCharacter(String query) async {
    try {
      Response result =
          await dio.get('$url/api/character', queryParameters: {'name': query});
      List<dynamic> characters = result.data['results'];
      print(characters);
      return characters.map((e) => Character.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Episode>> getEpisodesCharater(Character character) async {
    List<Episode> episodes = [];
    for (int i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
    }
    return episodes;
  }
}
