import 'dart:convert';

import 'package:service_products_business/models/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  Future<void> saveUser(String name, User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, jsonEncode(user));
    print('saveUser');
  }

  Future<User> getUser(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final temp = prefs.getString(name);
    final data = jsonDecode(temp);
    return data;
  }

  Future<String> getData(String name) async {
    final prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(name);
    print('getData : $data');
    return data;
  }

  Future<void> setData(String name, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, value);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
