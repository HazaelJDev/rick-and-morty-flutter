import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rick_and_morty/blocs/shared_preferences_bloc.dart';
import 'package:rick_and_morty/widgets/input_search.dart';
import 'package:rick_and_morty/widgets/item_list.dart';
import 'package:rick_and_morty/widgets/offline_status.dart';
import '../blocs/character_api_bloc.dart';
import '../utils/theme.dart';
import '../blocs/theme_bloc.dart';
//import 'package:rick_and_morty/repositories/character_db.dart';
//import '../blocs/connectivity_bloc.dart';
//import '../utils/fakeData.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeBloc>(context);
    //Check internet Conncetiovty
    //final status = Provider.of<ConnectivityBloc>(context);

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
              child: Builder(builder: (context) {
                final dataAPI = Provider.of<CharacterApiBloc>(context);
                final spDB = Provider.of<SharedPreferencesBloc>(context);
                dynamic characters = [];

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
                  characters = dataAPI.characters;
                  //save the data in the database
                  spDB.addSharedPreferences(1,theme.getIsDark(), json.encode(characters));
                }

                //When the app can't fetch data from the API 
                if (dataAPI.homeState == HomeState.error) {
                  print("sharedPreferencesDB: ${spDB.sharedPreferencesDB.toString()}");
                  
                  characters = json.decode(spDB.sharedPreferencesDB[0]?.data);
                  //if not exist data in the database
                  if (characters == []) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Text("We can't loaded the data dude :(", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: themeScheme.error),),
                      ],
                    );
                  }
                }

                //print("Character: ${characters}");

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 0,
                    right: 16,
                    bottom: 32,
                    left: 16,
                  ),
                  itemCount: characters.length,
                  itemBuilder: (context, index) => Item(characters[index]),
                );
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
    if (theme.getIsDark()) {
      theme.setTheme(darkTheme);
      spDB.sharedPreferencesDB == null ?
      spDB.addSharedPreferences(1,true, json.encode(dataAPI.characters))
      :spDB.updateSharedPreferencesDB(1,true, json.encode(dataAPI.characters));
    } else {
      theme.setTheme(lightTheme);
      spDB.sharedPreferencesDB == null ?
      spDB.addSharedPreferences(1,false, json.encode(dataAPI.characters))
      :spDB.updateSharedPreferencesDB(1,false, json.encode(dataAPI.characters));
    }
  }
}
