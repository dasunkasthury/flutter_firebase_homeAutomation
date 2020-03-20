import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScreenOne extends StatefulWidget {
  static const String id = 'screen_one';
  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final _auth = FirebaseAuth.instance;

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
        title: Center(
          child: Text("Home Automation App"),
        ),
      ),
      body: Center(
        child: Container(
          child: FlatButton(onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
          }, child: Text("signOut"),),
        ),
      ),
    );
  }
}
