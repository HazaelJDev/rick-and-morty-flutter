import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/blocs/character_api_bloc.dart';
import 'package:rick_and_morty/blocs/input_search_bloc.dart';
import './blocs/theme_bloc.dart';
import './blocs/connectivity_bloc.dart';
import 'blocs/shared_preferences_bloc.dart';
import './utils/theme.dart';
import './pages/splash_screen.dart';

//Objeto Global con la funcionalidad de checar el status de la conexión a internet
final internetChecker = CheckInternetConnection();

void main() {
  //Block the landscape orientation of the app
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeBloc(darkTheme),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (context) => ConnectivityBloc(),
        lazy: false, 
      ),
      ChangeNotifierProvider(
        create: (context) => CharacterApiBloc(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (context) => SharedPreferencesBloc(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (context) => InputSearchBloc(),
        lazy: false,
      ),
    ], child: const MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeBloc>(context);
    
    return MaterialApp(
      title: 'Rick and Morty App',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: theme.getTheme(),
    );
  }
}
