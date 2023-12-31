import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flash_chat/welcome_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static String id= 'splash';
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('images/logo.png'),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: Colors.deepOrange,
        nextScreen: WelcomeScreen(),
      ),
    );
  }
}
