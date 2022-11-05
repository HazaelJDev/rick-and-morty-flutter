import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/widgets/input_search.dart';
import 'package:rick_and_morty/widgets/item_list.dart';
import 'package:rick_and_morty/widgets/offline_status.dart';
import '../blocs/character_api_bloc.dart';
import '../utils/theme.dart';
import '../blocs/theme_bloc.dart';
import '../models/character_model.dart';
import '../repositories/character_service.dart';
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
              onPressed: () => changeTheme(theme),
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
              child: Builder(builder: (context){
                  final dataAPI = Provider.of<CharacterApiBloc>(context);
                  
                  if(dataAPI.homeState == HomeState.loading){
                    return const Center(child: Text("Loading the data..."));
                  }
                  
                  if(dataAPI.homeState == HomeState.error){
                    return Center(child: Text("An error has ocurred ${dataAPI.messageError}"));
                  }

                  final characters = dataAPI.characters;
                  
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
                }
              ),
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

  changeTheme(ThemeBloc theme) {
    if (theme.getIsDark()) {
      theme.setTheme(darkTheme);
    } else {
      theme.setTheme(lightTheme);
    }
  }
}
