
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_Screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  //final _firebase = FirebaseDatabase.instance.reference().child("chat").push();

  //////////////////////////for databse

  static Future<String> addNewSensor() async {
    var mountain = <String, dynamic>{
      'FrontLightStatus': '',
      'created': _getDateNow(),
    };

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("Home").push();

    reference.set(mountain);

    return reference.key;
  }

  static Future<void> saveSensorData(String locationKey, bool value) async {
    return FirebaseDatabase.instance
        .reference()
        .child("value")
        .set(value);
  }

  //////////////////////////////////

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      print(user.email);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      // var kk = await addNewSensor();

                      // print(kk);
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      await saveSensorData("-M2m3xhBv7SVlo8LWM_P", true);
                    },
                    child: Text("ON"),
                    color: Colors.green,
                  ),
                  FlatButton(
                    onPressed: () async {
                      await saveSensorData("-M2m3xhBv7SVlo8LWM_P", false);
                    },
                    child: Text("OFF"),
                    color: Colors.red,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}
