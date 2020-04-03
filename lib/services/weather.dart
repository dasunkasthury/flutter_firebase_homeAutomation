import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '63ea856131c7d34549e8a73304786ee8';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getLocationWether() async {
    Location location = new Location();
    await location.getLocation();
    Network network = new Network(
        'http://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.lon}&appid=$apiKey&units=metric');
    var decordedWetherData = await network.getData();
    return decordedWetherData;
  }

  Future<dynamic> getCityWether(String cityName) async {
    Network network = new Network(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var decordedCityWetherData = await network.getData();
    return decordedCityWetherData;
  }
}
