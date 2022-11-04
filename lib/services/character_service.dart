import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';


class CharacterService {
  static const _scheme = 'https';
  static const _host = 'rickandmortyapi.com';
  static const _path = '/api/character';
  
  static final Uri _url1 = Uri(
    scheme: _scheme,
    host: _host,
    path: _path,
  );
  static final Uri _url2 = Uri(
    scheme: _scheme,
    host: _host,
    path: _path,
    queryParameters: {
      'page': '2',
    },
  );
  static final Uri _url3 = Uri(
    scheme: _scheme,
    host: _host,
    path: _path,
    queryParameters: {
      'page': '3',
    },
  );
  
  static Future<List<Character>> getCharacters() async {
    final response = await http.get(_url1);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final results = json['results'];
      return results.map<Character>((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}