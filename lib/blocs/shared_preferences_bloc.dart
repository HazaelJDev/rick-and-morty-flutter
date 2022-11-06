import 'package:flutter/material.dart';
import '../repositories/character_db.dart';


class SharedPreferencesBloc extends ChangeNotifier{
  dynamic sharedPreferencesDB = [];


  SharedPreferencesBloc(){
    SharedPreferencesDB();
    sharedPreferencesDB = SharedPreferencesDB().readSharedPreferences();
  }

  addSharedPreferences(int id,bool isDark, String data) async{
    final sp = SharedPreferences(id: id, isDark: isDark, data: data);
    await SharedPreferencesDB().insertSharedPreferences(sp);
    sharedPreferencesDB = SharedPreferencesDB().readSharedPreferences();
    notifyListeners();
  }

  updateSharedPreferencesDB(int id,bool isDark, String data) async{
    final sp = SharedPreferences(id: id, isDark: isDark, data: data);
    await SharedPreferencesDB().updateSharedPreferences(sp);
    sharedPreferencesDB = SharedPreferencesDB().readSharedPreferences();
    notifyListeners();
  }

  deleteSharedPreferencesDB(int id) async{
    await SharedPreferencesDB().deleteSharedPreferences(id);
    sharedPreferencesDB = SharedPreferencesDB().readSharedPreferences();
    notifyListeners();
  }

}