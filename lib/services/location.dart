import 'package:geolocator/geolocator.dart';

class Location {
  double lon;
  double lat;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lon = position.longitude;
      lat = position.latitude;
    } catch (e) { print(e);}
  }
}
