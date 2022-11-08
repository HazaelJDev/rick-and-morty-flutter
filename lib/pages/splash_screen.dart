import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../blocs/shared_preferences_bloc.dart';
import '../blocs/theme_bloc.dart';
import '../utils/theme.dart';
import './home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    //Set Theme from Shared Preferences
    final spDB = Provider.of<SharedPreferencesBloc>(context,listen: false);
    final theme = Provider.of<ThemeBloc>(context,listen: false);
    dynamic themeD;
    

    if(spDB.sharedPreferencesDB.isNotEmpty){
      print("${spDB.sharedPreferencesDB[0].isDark}");

      themeD = spDB.sharedPreferencesDB[0].isDark ? darkTheme : lightTheme;
      theme.setTheme(themeD);
      theme.setIsDark(spDB.sharedPreferencesDB[0].isDark);
    }
    
    //Wait 4 seconds and then navigate to Home Page
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141927),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Image(
                image: AssetImage("assets/image/logo.png"),
                width: 280,
              ),
              SizedBox(
                height: 28,
              ),
              SpinKitChasingDots(
                color: Color(0xFFF9F9F9),
                size: 50.0,
                duration: Duration(milliseconds: 800),
              ),
            ],
          ),
        ));
  }
}
