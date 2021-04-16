import 'dart:io';

const String myip = '192.168.1.17';
const String local = '10.0.2.2';

class Environment {
  static String apiUrl =
      Platform.isAndroid ? 'http://$local:8080' : 'http://$local:8080';
  static String socketUrl =
      Platform.isAndroid ? 'http://$local:5001' : 'http://$local:5001';
}
