import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/weather.dart';
import './city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temp;
  String weatherIcon;
  String cityName;
  String weatherMsg;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic locationWeather) {
    if (locationWeather == null) {
      setState(() {
        temp = 0;
        cityName = '';
        weatherIcon = 'Error';
        weatherMsg = 'unable to ger weather';
      });

      return;
    }
    double temp1 = locationWeather['main']['temp'];
    setState(() {
      temp = temp1.toInt();
      cityName = locationWeather['name'];
      weatherIcon = weather.getWeatherIcon(locationWeather['weather'][0]['id']);
      weatherMsg = weather.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      updateUI(
                        await weather.getLocationWether(),
                      );
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (typedCityName != null) {
                        var cityWeatherData =
                            await weather.getCityWether(typedCityName);
                        updateUI(cityWeatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "$temp",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMsg in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ['coord']['lon'];
// wheatherDescription =
//     jsonDecode(res.body)['weather'][0]['description'];
// print(longitude);
// print(wheatherDescription);
