import 'package:flutter/material.dart';
import '../repositories/character_service.dart';
import '../models/character_model.dart';

enum HomeState{
  initial,
  loading,  
  loaded,
  error
}

class CharacterApiBloc extends ChangeNotifier{
  HomeState _homeState = HomeState.initial;
  List<Character> characters = [];
  String messageError = "";

  CharacterApiBloc(){
    fetchCharacters();
  }


  HomeState get homeState => _homeState;

  Future<void> fetchCharacters() async{
    _homeState = HomeState.loading;
    try{
      final charactersapi = await CharacterService.getCharacters();    
      characters = charactersapi; 
      _homeState = HomeState.loaded;
    }catch(e){
      messageError = e.toString();
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}