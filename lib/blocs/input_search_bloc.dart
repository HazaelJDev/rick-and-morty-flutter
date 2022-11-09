import 'package:flutter/material.dart';
import '../models/character_model.dart';

class InputSearchBloc extends ChangeNotifier{
  dynamic characters;
  List<Character> searchedCharacters;
  String messageError;

  //Constructor with optionals properties
  InputSearchBloc({this.characters = const [], this.searchedCharacters = const [], this.messageError = ""});

  void search(String value) {
    dynamic auxFiltered = {};
    dynamic auxSetFiltered = {};
    if(characters.isNotEmpty) {
      //Search characters by name and location name too.
      auxSetFiltered = characters.where((character) => character.name.toLowerCase().contains(value.toLowerCase())? true : false).toSet();
      auxFiltered = characters.where((character) => character.species.toLowerCase().contains(value.toLowerCase())? true : false).toSet();
      //Remove duplicates with union
      auxSetFiltered.union(auxFiltered);
      
      auxFiltered = List<Character>.from(auxSetFiltered);

      searchedCharacters = auxFiltered;

      if(searchedCharacters.isEmpty) {
        messageError = "No results found";
      }else{
        messageError = ""; 
      }


    }else{
      messageError = "There are no characters to search";
    }
    notifyListeners();
  }
  
}