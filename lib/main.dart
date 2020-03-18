import 'package:flutter/material.dart';
import './input_page.dart';

void main() => runApp(HomeAutomationApp());

class HomeAutomationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xff2196F3),
        accentColor: Colors.greenAccent,
        scaffoldBackgroundColor: Colors.lime,
        textTheme: TextTheme(body1: TextStyle(color: Colors.black),) ,
      ),
      home: HomeAutomationFirstPage(),
    );
  }
}


