import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/global_screen.dart';
import 'package:flash_chat/splash_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'chat_screen.dart';
import 'welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDohjBX9N3rEgi8jGachVjdllRTDoa_6DI',
          appId: "com.example.msg_app",
          messagingSenderId: null,
          projectId: 'msgapp-9e2da'));
  runApp(MsgApp());
}

class MsgApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      home: Splash(),
      initialRoute: Splash.id,
      routes: {
        Splash.id:(context)=>Splash(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        Globlimg.id: (context)=>Globlimg(),
      },
    );
  }
}
