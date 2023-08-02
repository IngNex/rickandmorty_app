import 'package:flutter/material.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/domain/models/episode_models.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];
  List<Episode> episodes = [];

  Future<void> getCharacters(int page) async {
    final result = await http.get(
      Uri.https(url, '/api/character', {'page': page.toString()}),
    );
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Episode>> getEpisodes(Character character) async {
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }

    return episodes;
  }

  Future<List<Character>> getCharater(String name) async {
    final result = await http.get(
      Uri.https(url, '/api/character/', {'name': name}),
    );
    final response = characterResponseFromJson(result.body);
    notifyListeners();
    return response.results!;
  }
}
