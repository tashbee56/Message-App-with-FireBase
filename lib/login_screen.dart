import 'package:flash_chat/global_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'chat_screen.dart';
import 'welcome_screen.dart';
import 'constants.dart';
import 'bt1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends StatefulWidget  {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
String email;
String pass;

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  void initState(){
    super.initState();
    controller=AnimationController(vsync: this,
    duration: Duration(seconds: 1),
    upperBound: 1.0);
    animation= CurvedAnimation(parent: controller, curve: Curves.easeOutCirc);
    controller.forward();
    controller.addListener(() {
setState((){});
      print(controller.value);
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }



  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.deepOrange,
      //   title: Text(
      //     'Global chat login'
      //   ),
      //   elevation: 10,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
      //   ),
      //   toolbarHeight: 10,
      //   toolbarOpacity: 10,
      // ),
      body: LoadingOverlay(
        isLoading: show,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'pic',
                child: Container(
                  height: animation.value *100 ,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              style: TextStyle(color: Colors.cyanAccent , fontSize: 12),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              style: TextStyle(color: Colors.cyanAccent , fontSize: 12),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                pass = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password.',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            bt1(
              color: Colors.lightBlueAccent,
              txt: 'login',
              func: () async{
                setState(() {
                  show = true;
                });
                try {
                  final user =await _auth.signInWithEmailAndPassword(
                      email: email, password: pass);
                  if (user != null) {
                   await Navigator.pushNamed(context, Globlimg.id);
                  }
                  setState((){
                    show= false;
                  });
                } catch (e) {
                  print(e);
                }
                setState(() {
                  show = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
