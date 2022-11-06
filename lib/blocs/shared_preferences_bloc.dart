import 'package:flutter/material.dart';
import '../repositories/character_db.dart';


class SharedPreferencesBloc extends ChangeNotifier{
  dynamic sharedPreferencesDB = [];


  SharedPreferencesBloc(){
    //SharedPreferencesDB();
    sharedPreferencesDB = SharedPreferencesDB.instance.readSharedPreferences();
  }

  addSharedPreferences(int id,bool isDark, String data) async{
    print("id to add: $id");
    print("isDark to add: $isDark");
    print("Data to add: ${data.runtimeType}");
    final sp = SharedPreferences(id: id, isDark: isDark, data: data);
    await SharedPreferencesDB.instance.insertSharedPreferences(sp);
    sharedPreferencesDB = SharedPreferencesDB.instance.readSharedPreferences();
    notifyListeners();
  }

  updateSharedPreferencesDB(int id,bool isDark, String data) async{
    final sp = SharedPreferences(id: id, isDark: isDark, data: data);
    await SharedPreferencesDB.instance.updateSharedPreferences(sp);
    sharedPreferencesDB = SharedPreferencesDB.instance.readSharedPreferences();
    notifyListeners();
  }

  deleteSharedPreferencesDB(int id) async{
    await SharedPreferencesDB.instance.deleteSharedPreferences(id);
    sharedPreferencesDB = SharedPreferencesDB.instance.readSharedPreferences();
    notifyListeners();
  }

}