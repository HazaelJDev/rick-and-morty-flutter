import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rick_and_morty/blocs/input_search_bloc.dart';
import 'package:rick_and_morty/blocs/shared_preferences_bloc.dart';
import 'package:rick_and_morty/widgets/input_search.dart';
import 'package:rick_and_morty/widgets/item_list.dart';
import 'package:rick_and_morty/widgets/offline_status.dart';
import '../blocs/character_api_bloc.dart';
import '../blocs/connectivity_bloc.dart';
import '../models/character_model.dart';
import '../utils/theme.dart';
import '../blocs/theme_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeBloc>(context);
    final input = Provider.of<InputSearchBloc>(context);
    //dynamic characters = [];
    //dynamic searchedCharacters = [];
    
    final themeScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => openAbout(context),
            icon: Icon(Icons.info_outline, color: themeScheme.onBackground),
            tooltip: "About this app",
          ),
          title: const Text('Rick and Morty App'),
          actions: [
            IconButton(
              onPressed: () => changeTheme(theme,context),
              icon:
                  Icon(theme.getIsDark() ? Icons.light_mode : Icons.dark_mode),
              tooltip: "Change theme",
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const OfflineBottomBar(),
            Container(
              padding: const EdgeInsets.only(
                top: 28,
                right: 16,
                bottom: 32,
                left: 16,
              ),
              child: InputSearch("Search for a character"),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                final dataAPI = Provider.of<CharacterApiBloc>(context);
                final spDB = Provider.of<SharedPreferencesBloc>(context);
                //final network = Provider.of<ConnectivityBloc>(context);
                
                //When the app is loading data from the API
                if (dataAPI.homeState == HomeState.loading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SpinKitFadingCube(
                        color: themeScheme.primary,
                        size: 50.0,
                        duration: const Duration(milliseconds: 800),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text("Loading the data...", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: themeScheme.primary),),
                    ],
                  );
                }

                //When the app loaded data successfully from the API
                if (dataAPI.homeState == HomeState.loaded) {
                  input.characters = dataAPI.characters;
                  //save the data in the database
                  if(json.encode(dataAPI.characters) != spDB.sharedPreferencesDB[0].data){
                    print("guardando en la base de datos");
                    spDB.addSharedPreferences(1,theme.getIsDark(), json.encode(input.characters));
                  }
                    
                }

                //When the app can't fetch data from the API
                if (dataAPI.homeState == HomeState.error) {
                  
                  if(spDB.sharedPreferencesDB.isNotEmpty){
                    print("sharedPreferencesDB: ${spDB.sharedPreferencesDB[0]}");
                    
                    input.characters = json.decode(spDB.sharedPreferencesDB[0].data);
                    
                    for (var i = 0; i < input.characters.length; i++) {
                      input.characters[i] = Character.fromJson(input.characters[i]);
                    }
                  }

                  //if not exist data in the database
                  if (input.characters.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                          size: 120,
                        ),
                        const SizedBox(
                          height: 8,
                          width: double.infinity,
                        ),
                        Text("We can't loaded the data dude :(", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: themeScheme.error,),),
                      ],
                    );
                  }
                }
                
                if(input.messageError != ""){
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                          size: 120,
                        ),
                        const SizedBox(
                          height: 8,
                          width: double.infinity,
                        ),
                        Text("We don't have this information :(", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: themeScheme.error,),),
                      ],
                    );
                }

                if(input.searchedCharacters.isEmpty){
                  //List all the characters
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 0,
                      right: 16,
                      bottom: 32,
                      left: 16,
                    ),
                    itemCount: input.characters.length,
                    itemBuilder: (context, index) => Item(input.characters[index]),
                  );
                }else{
                  //List the searched characters
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 0,
                      right: 16,
                      bottom: 32,
                      left: 16,
                    ),
                    itemCount: input.searchedCharacters.length,
                    itemBuilder: (context, index) => Item(input.searchedCharacters[index]),
                  );
                }
                
              }),
            ),
          ],
        ));
  }

  searchCharacter() {}

  openCharacter(BuildContext context) {}

  openAbout(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('About this app'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                  'This is a simple app that shows the characters from the Rick and Morty TV show.'),
              Text('by: '),
              Image(
                image: AssetImage("assets/image/logo2.png"),
                width: 80,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  changeTheme(ThemeBloc theme, BuildContext context) {
    final dataAPI = Provider.of<CharacterApiBloc>(context,listen: false);
    final spDB = Provider.of<SharedPreferencesBloc>(context,listen: false);
    dynamic dataToSave = [];
    //check the data to save in the database
    if(dataAPI.characters.isEmpty){
      dataToSave = spDB.sharedPreferencesDB.isEmpty ? "[]" : spDB.sharedPreferencesDB[0].data;
    }else{
      dataToSave = json.encode(dataAPI.characters) ;
    }

    if (theme.getIsDark()) {
      theme.setTheme(darkTheme);
      spDB.sharedPreferencesDB.isEmpty ?
      spDB.addSharedPreferences(1,true, dataToSave)
      :spDB.updateSharedPreferencesDB(1,true, dataToSave);
    } else {
      theme.setTheme(lightTheme);
      spDB.sharedPreferencesDB.isEmpty ?
      spDB.addSharedPreferences(1,false, dataToSave)
      :spDB.updateSharedPreferencesDB(1,false, dataToSave);
    }
  }
}
