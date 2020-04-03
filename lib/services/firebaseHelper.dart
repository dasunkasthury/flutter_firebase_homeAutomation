import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class FirebaseHelper {
  static Future<String> addNewSensor() async {
    var mountain = <String, dynamic>{
      'FrontLightStatus': '',
      'created': _getDateNow(),
    };

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("Home").push();

    reference.set(mountain);

    return reference.key;
  }

  static Future<void> saveSensorData(bool value) async {
    return FirebaseDatabase.instance.reference().child("value").set(value);
  }

  static Future<void> saveRGB({int red, int green, int blue}) async {
    await FirebaseDatabase.instance.reference().child("Red").set(red);
    await FirebaseDatabase.instance.reference().child("Green").set(green);
    await FirebaseDatabase.instance.reference().child("Blue").set(blue);
  }

  static Future<void> setRelayOne({int value}) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Relays")
        .child("switch1")
        .set(value);
  }

  static Future<void> setRelayTwo({int value}) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Relays")
        .child("switch2")
        .set(value);
  }

  static Future<void> setRelayThree({int value}) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Relays")
        .child("switch3")
        .set(value);
  }

  static Future<void> setRelayFour({int value}) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Relays")
        .child("switch4")
        .set(value);
  }

  static Future<int> getFirstRelayStatus() async {
    int temp;
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("Relays")
        .child("switch1")
        .once();
    temp = snapshot.value;
    return temp;
  }
}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}
