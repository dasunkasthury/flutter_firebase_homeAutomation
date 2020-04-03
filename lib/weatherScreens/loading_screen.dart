import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './location_screen.dart';
import '../services/weather.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var decordedWetherData = await WeatherModel().getLocationWether();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(decordedWetherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitWave(
        color: Colors.blueAccent,
        size: 70.0,
      ),
    ));
  }
}
