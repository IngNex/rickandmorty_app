import 'package:dio/dio.dart';
import 'package:rickandmorty/domain/models/character_models.dart';

class ApiProvider {
  final dio = Dio();
  final String _url = 'https://rickandmortyapi.com/api/character';
  Future<List<Character>> getCharacters(int page) async {
    try {
      Response result =
          await dio.get(_url, queryParameters: {'page': page.toString()});
      List<dynamic> characters = result.data['results'];

      return characters.map((e) => Character.fromJson(e)).toList();
    } catch (e) {
      if (e.toString().contains("Socket Exception")) {
        return [Character.withError("Check your internet connection please")];
      }
      return [Character.withError(e.toString())];
    }
  }
}
