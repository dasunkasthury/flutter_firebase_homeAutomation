import 'package:flutter/material.dart';
import '../services/firebaseHelper.dart';

class RelayScreen extends StatefulWidget {
  static const String id = 'Relay_Screen';
  @override
  _RelayScreenState createState() => _RelayScreenState();
}

class _RelayScreenState extends State<RelayScreen> {
  int relay1Status;

  @override
  void initState() {
    super.initState();

    // setState(() async {
    //   relay1Status = await FirebaseHelper.getFirstRelayStatus();
    // });
  }

  // FirebaseHelper firebase = FirebaseHelper();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayOne(value: 10);
                          setState(() async {
                            relay1Status =
                                await FirebaseHelper.getFirstRelayStatus();
                          });
                        },
                        child: Text("S1 ON"),
                        color: Colors.red,
                      ),
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayOne(value: 5);
                          setState(() async {
                            relay1Status =
                                await FirebaseHelper.getFirstRelayStatus();
                          });
                        },
                        child: Text("S1 OFF"),
                        color: Colors.blueAccent,
                      ),
                      FlatButton(
                        onPressed: () {
                          print(relay1Status);
                        },
                        child: Text("state"),
                        color: relay1Status == 10
                            ? Colors.yellowAccent
                            : Colors.white,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayTwo(value: 10);
                        },
                        child: Text("S2 ON"),
                        color: Colors.red,
                      ),
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayTwo(value: 5);
                        },
                        child: Text("S2 OFF"),
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayThree(value: 10);
                        },
                        child: Text("S3 ON"),
                        color: Colors.red,
                      ),
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayThree(value: 5);
                        },
                        child: Text("S3 OFF"),
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayFour(value: 10);
                        },
                        child: Text("S4 ON"),
                        color: Colors.red,
                      ),
                      FlatButton(
                        onPressed: () async {
                          await FirebaseHelper.setRelayFour(value: 5);
                        },
                        child: Text("S4 OFF"),
                        color: Colors.blueAccent,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
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
