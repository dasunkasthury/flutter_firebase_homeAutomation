import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebaseHelper.dart';

class LedScreen extends StatefulWidget {
  static const String id = 'LED_Screen';
  @override
  _LedScreenState createState() => _LedScreenState();
}

class _LedScreenState extends State<LedScreen> {
  final _auth = FirebaseAuth.instance;

  // FirebaseHelper firebase = FirebaseHelper();

  int red;
  int green;
  int blue;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    print(color);
  }

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

  _showWarninigs(BuildContext context, Future x) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            title: Text('Are you sure'),
            content: Text('This action can not be undone!'),
            actions: <Widget>[
              FlatButton(
                child: Text('OFF'),
                onPressed: () async {
                  Navigator.pop(context);
                  // Navigator.pop(context, true);
                  await x;
                },
              ),
              FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text(
              'Relay Set',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'relay_screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(
              'RGB',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'led_screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('⚡️LED'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black54,
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.white12,
                          ),
                          hintText: 'Enter red ',
                          hintStyle: TextStyle(color: Colors.white10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onChanged: (value) {
                        red = int.parse(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black54,
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.white12,
                          ),
                          hintText: 'Enter green',
                          hintStyle: TextStyle(color: Colors.white10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onChanged: (value) {
                        green = int.parse(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black54,
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.white12,
                          ),
                          hintText: 'Enter blue',
                          hintStyle: TextStyle(color: Colors.white10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onChanged: (value) {
                        blue = int.parse(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () async {
                        await FirebaseHelper.saveRGB(
                            red: red, green: green, blue: blue);
                      },
                      child: Text("set"),
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        await FirebaseHelper.saveSensorData(true);
                      },
                      child: Text("ON"),
                      color: Colors.green,
                    ),
                    FlatButton(
                      onPressed: () async {
                        _showWarninigs(
                            context, FirebaseHelper.saveSensorData(false));
                        // await FirebaseHelper.saveSensorData(false);
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
      ),
    );
  }
}
