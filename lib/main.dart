import 'package:flutter/material.dart';
import './screens/welcome_screen.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import './chatAppScreens/chat_screen.dart';
import './sensorScreens/led.dart';
import './sensorScreens/relay.dart';

void main() => runApp(HomeAutomationApp());

class HomeAutomationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xff2196F3),
        accentColor: Colors.greenAccent,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(body1: TextStyle(color: Colors.black),) ,
      ),
      initialRoute: WelcomeScreen.id,//
      routes: {
        WelcomeScreen.id : (context)=> WelcomeScreen(),
        'logIn_screen': (context)=> LoginScreen(),
        'registration_screen': (context)=> RegistrationScreen(),
        'chat_screen': (context)=> ChatScreen(),
        'led_screen': (context)=> LedScreen(),
        'relay_screen': (context)=> RelayScreen(),
      },
    );
  }
}


