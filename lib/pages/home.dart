import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/theme_bloc.dart';
import '../utils/theme.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => openAbout(context),
            icon: Icon(Icons.info_outline,
                color: Theme.of(context).colorScheme.onBackground),
            tooltip: "About this app",
          ),
          title: const Text('Rick and Morty App'),
          actions: [
            IconButton(
              onPressed: () => changeTheme(theme),
              icon:
                  Icon(theme.getIsDark() ? Icons.dark_mode : Icons.light_mode),
              tooltip: "Change theme",
            ),
          ],
        ),
        body: const Center(
          child: Text("Hola mundo"),
        ));
  }  

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

