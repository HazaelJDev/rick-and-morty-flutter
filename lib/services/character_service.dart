import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';


class CharacterService {
  /*static CharacterService? _instance;

  CharacterService._();

  static CharacterService? get instance {
    if (_instance == null) {
      _instance = CharacterService._();
    }
    return _instance;
  }*/
  
  
  
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
    final response1 = await http.get(_url1);
    final response2 = await http.get(_url2);
    final response3 = await http.get(_url3);
    
    if (response1.statusCode == 200 && response2.statusCode == 200 && response3.statusCode == 200) {
      final json1 = jsonDecode(response1.body);
      final json2 = jsonDecode(response2.body);
      final json3 = jsonDecode(response3.body);
      
      final results1 = json1['results'];
      final results2 = json2['results'];
      final results3 = json3['results'];


      final res1 = results1.map<Character>((json) => Character.fromJson(json)).toList();
      final res2 = results2.map<Character>((json) => Character.fromJson(json)).toList();
      final res3 = results3.map<Character>((json) => Character.fromJson(json)).toList();
      return [...res1,...res2,...res3];
    } else {
      throw Exception('Failed to load characters');
    }
  }
}