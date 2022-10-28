import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

    Future.delayed(const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      )
      );
          
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
              SpinKitChasingDots
              (
                color: Color(0xFFF9F9F9),
                size: 50.0,
                duration: Duration(milliseconds: 800),
              ),
            ],
          ),
        ));
  }
}
