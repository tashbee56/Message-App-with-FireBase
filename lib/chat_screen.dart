import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'chat_screen.dart';
import 'welcome_screen.dart';
import 'constants.dart';
import 'bt1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _store = FirebaseFirestore.instance;
User loggedinuser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final con = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String messagetext;
  bool me;

  void initState() {
    super.initState();
    getcurrentuser();
  }

  // void messageStream() async {
  //   await for (var snapshot in _store.collection('mess').snapshots()) {
  //     for (var m in snapshot.docs) {
  //       print(m.data());
  //     }
  //   }
  // }

  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser;
      print(user);
      if (user != null) {
        loggedinuser = user;
        print(loggedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Streams(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style:
                            TextStyle(color: Colors.cyanAccent, fontSize: 15),
                        controller: con,
                        onChanged: (value) {
                          messagetext = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        con.clear();
                        _store.collection('mess').add({
                          'text': messagetext,
                          'sender': loggedinuser.email
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Streams extends StatelessWidget {
  const Streams({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.collection('mess').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black54,
              ),
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<msg> list = [];
        list.reversed;
        for (var m in messages) {
          final messagesender = m.get('sender');
          final messagetext1 = m.get('text');
          final User = loggedinuser.email;
          final msgwidget = msg(
            messagetext1: messagetext1,
            messagesender: messagesender,
            me: User == messagesender,
          );

          list.add(msgwidget);

        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.all(5),
            children: list,
          ),
        );
      },
    );
  }
}

class msg extends StatelessWidget {
  final String messagetext1;
  final String messagesender;
  final bool me;
  final Timestamp time;

  const msg(
      {Key key, this.messagetext1, this.messagesender, this.me, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            messagesender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            elevation: 10,
            borderRadius: me
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
            color: me ? Colors.blue : Colors.cyanAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                '$messagetext1',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
