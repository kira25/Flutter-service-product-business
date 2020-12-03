import 'dart:io';

const String myip = '192.168.1.10';
const String local = '10.0.2.2';

class Environment {
  static String apiUrl =
      Platform.isAndroid ? 'http://$myip:5000' : 'http://$myip:5000';
  static String socketUrl =
      Platform.isAndroid ? 'http://$myip:5001' : 'http://$myip:5001';
}
