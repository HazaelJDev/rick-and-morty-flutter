import 'package:flutter/material.dart';
import '../repositories/character_db.dart';


class SharedPreferencesBloc extends ChangeNotifier{
  dynamic sharedPreferencesDB = [];
  //dynamic _aux = [];

  SharedPreferencesBloc() {
    //SharedPreferencesDB();
    SharedPreferencesDB.instance.readSharedPreferences().then((value) => sharedPreferencesDB = value);
  }

  addSharedPreferences(int id,bool isDark, String data) async{
    final sp = SharedPreferences(id: id, isDark: isDark, data: data);
    await SharedPreferencesDB.instance.insertSharedPreferences(sp);
    /*_aux = SharedPreferencesDB.instance.readSharedPreferences();
    sharedPreferencesDB = _aux;*/
    SharedPreferencesDB.instance.readSharedPreferences().then((value) => sharedPreferencesDB = value);
    notifyListeners();
  }

  updateSharedPreferencesDB(int id,bool isDark, String data) async{
    final sp = SharedPreferences(id: id, isDark: isDark, data: data);
    await SharedPreferencesDB.instance.updateSharedPreferences(sp);
    /*_aux = SharedPreferencesDB.instance.readSharedPreferences();
    sharedPreferencesDB = _aux;*/
    SharedPreferencesDB.instance.readSharedPreferences().then((value) => sharedPreferencesDB = value);
    notifyListeners();
  }

  deleteSharedPreferencesDB(int id) async{
    await SharedPreferencesDB.instance.deleteSharedPreferences(id);
    /*_aux = SharedPreferencesDB.instance.readSharedPreferences();
    sharedPreferencesDB = _aux;*/
    SharedPreferencesDB.instance.readSharedPreferences().then((value) => sharedPreferencesDB = value);
    notifyListeners();
  }

}