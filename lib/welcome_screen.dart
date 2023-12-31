import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'bt1.dart';


class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  void func() {
    Navigator.pushNamed(context, LoginScreen.id);
  }

  AnimationController con;
  Animation animation;
  Animation animation2;

  void initState() {
    super.initState();
    con = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = CurvedAnimation(parent: con, curve: Curves.decelerate);
    animation2 = ColorTween(begin: Colors.deepOrange, end: Colors.cyanAccent)
        .animate(con);
    con.reverse(from: 1);
    con.addListener(() {
      setState(() {});
      print(animation2.value);
    });

    con.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        con.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        con.forward();
      }
    });
  }

  void dispose() {
    con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(con.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'pic',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            bt1(
              color: Colors.cyanAccent,
              txt: 'login',
              func: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            bt1(
              color: Colors.brown,
              txt: 'Register',
              func: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
