import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ricknmorty/data/model/character.dart';

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api/';

  Future<CharacterList> characterList() async {
    final response = await http.get(Uri.parse("${_baseUrl}character"));
    if (response.statusCode == 200) {
      return CharacterList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Character> character(int id) async {
    final response = await http.get(Uri.parse("${_baseUrl}character/$id"));
    if (response.statusCode == 200) {
      return Character.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }
}
