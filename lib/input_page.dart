import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAutomationFirstPage extends StatefulWidget {
  @override
  _HomeAutomationFirstPageState createState() =>
      _HomeAutomationFirstPageState();
}

class _HomeAutomationFirstPageState extends State<HomeAutomationFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Home Automation App"),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: ReusableCard(
                color: Color(0xff191b22),
                cardChild: Column(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.mars,
                      size: 80,
                    ),
                    SizedBox(height: 15,),
                    Text("MALE", style: TextStyle(fontSize: 18),)
                  ],
                ),
              )),
              Expanded(child: ReusableCard(color: Color(0xff191b22))),
            ],
          )),
          Expanded(child: ReusableCard(color: Color(0xff191b22))),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(child: ReusableCard(color: Color(0xff191b22))),
              Expanded(child: ReusableCard(color: Color(0xff191b22))),
            ],
          )),
          Container(
            color: Colors.pinkAccent,
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 80,
          )
        ],
      )),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.color, this.cardChild});
  final Color color;
  final Widget cardChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
    );
  }
}
