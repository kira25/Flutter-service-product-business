import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/models/user_response.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';

class AuthService {
  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();
  factory AuthService() {
    return _instance;
  }

  final PreferencesRepository _preferencesRepository = PreferencesRepository();
  final _dio = new Dio();
  final _registerPath = '${Environment.apiUrl}/users/create';
  final _loginPath = '${Environment.apiUrl}/auth/login';
  final _sendEmailPath = '${Environment.apiUrl}/users/sendEmail';
  final _verifyPasswordPinPath =
      '${Environment.apiUrl}/users/verifyPasswordPin';
  final _resetPasswordPath = '${Environment.apiUrl}/users/resetPassword';
  final _renewPath = '${Environment.apiUrl}/users/renew';

  Future renew(String token) async {
    if (token == null) return [false, false];
    try {
      final resp = await _dio.get(_renewPath,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
      print(resp.data);
      final data = UserResponse.fromJson(resp.data);
      print(data);

      if (resp.data['ok'] == true && resp.data['user']['isShopInfo'] == true) {
        return [true, true];
      } else if (resp.data['ok'] == true && resp.data['user']['isShopInfo'] == false) {
        return [true, false];
      } else {
        _preferencesRepository.clear();
        return [false, false];
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future register(
    String firstname,
    String lastname,
    String identifier,
    String email,
    String cellphone,
    String shopName,
    String password,
  ) async {
    final data = {
      "firstname": firstname,
      "lastname": lastname,
      "password": password,
      "email": email,
      "identifier": int.parse(identifier),
      "cellphone": int.parse(cellphone),
      "shopName": shopName,
      "role": 2
    };

    final resp = await _dio.post(_registerPath, data: data);

    if (resp.data['ok'] == true) {
      final data = UserResponse.fromJson(resp.data);
      _preferencesRepository.saveUser('user', data.user);
      _preferencesRepository.setData('token', data.token);
      print(data);
      print(resp.data);
      return true;
    } else {
      return false;
    }
  }

  Future logIn(String email, String password) async {
    final data = {"password": password, "email": email};
    final resp = await _dio.post(_loginPath, data: data);
    if (resp.data['ok'] == true && resp.data['user']['isShopInfo'] == false) {
      final user = UserResponse.fromJson(resp.data);
      _preferencesRepository.saveUser('user', user.user);
      _preferencesRepository.setData('token', user.token);
      print(data);
      print(resp.data);
      return [true, false];
    } else if (resp.data['ok'] == true && resp.data['user']['isShopInfo'] == true) {
      final user = UserResponse.fromJson(resp.data);
      _preferencesRepository.saveUser('user', user.user);
      _preferencesRepository.setData('token', user.token);
      return [true, true];
    } else {
      return [false, false];
    }
  }

  Future sendEmail(String email) async {
    final data = {"email": email};
    final resp = await _dio.post(_sendEmailPath, data: data);
    if (resp.data['ok'] == true) {
      return true;
    } else {
      return false;
    }
  }

  Future verifyPasswordToken(String email, String pin) async {
    final data = {"email": email, "pin": pin};
    final resp = await _dio.post(_verifyPasswordPinPath, data: data);
    if (resp.data['ok'] == true) {
      return resp.data['response'];
    } else {
      return null;
    }
  }

  Future resetPassword(
      String email, String password, String passwordToken) async {
    final data = {
      "email": email,
      "password": password,
      "passwordToken": passwordToken
    };
    final resp = await _dio.post(_resetPasswordPath, data: data);
    if (resp.data['ok'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
