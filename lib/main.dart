import 'package:flutter/material.dart';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import './question.dart';

void main() => runApp(HomeAutomationApp());

class HomeAutomationApp extends StatefulWidget {
  @override
  _HomeAutomationAppState createState() => _HomeAutomationAppState();
}

class _HomeAutomationAppState extends State<HomeAutomationApp> {
  var size1 = 100.1;
  int questionNumber = 0;

  List<Icon> scoreKeeper = [];

  void playSound(int soundIndex) {
    final assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      "assets/note$soundIndex.wav",
    );
    assetsAudioPlayer.play();
  }

  FlatButton soundKey(int soundNumber, Color color) {
    return FlatButton(
      onPressed: () {
        playSound(soundNumber);
      },
      child: Container(
        height: 20,
        width: 100,
        color: color,
      ),
    );
  }

  List<Question> qList = [
    new Question(q: 'aa', a: true),
    new Question(q: 'bb', a: false),
    new Question(q: 'cc', a: true)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Home Automation App"),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage('images/robot.png'),
                  height: 200,
                  width: 150,
                ),
                Text(nouns.first),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    soundKey(1, Colors.green),
                    soundKey(2, Colors.red),
                    soundKey(3, Colors.blue),
                    Row(
                      children: scoreKeeper,
                    ),
                    Text(qList[questionNumber].questionText),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          if (questionNumber < 2) {
                            questionNumber++;
                          }
                        });

                        if (qList[questionNumber].questionAnswer == true) {
                          setState(() {
                            scoreKeeper.add(Icon(
                              Icons.check,
                              color: Colors.white,
                            ));
                          });
                        }
                      },
                      child: Text("TRUE"),
                      color: Colors.purple,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        backgroundColor: Colors.lime,
      ),
    );
  }
}
