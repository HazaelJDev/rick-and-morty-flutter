import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './blocs/theme_bloc.dart';
import './utils/theme.dart';
import './pages/splash_screen.dart';
import './pages/home.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ThemeBloc(darkTheme),
      child: const MaterialAppWithTheme(),
    );
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
