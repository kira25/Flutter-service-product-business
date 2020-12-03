import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/models/shop_response.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';

class ShopService {
  ShopService._privateConstructor();

  static final ShopService _instance =
   ShopService._privateConstructor();

  factory ShopService() {
    return _instance;
  }

  final PreferencesRepository _preferencesRepository = PreferencesRepository();
  final _dio = new Dio();
  final _shopCreate = '${Environment.apiUrl}/shop/create';
  final _shopUpdate = '${Environment.apiUrl}/shop/update';
  final _shopInfo = '${Environment.apiUrl}/shop/info';

  Future createShop(
      String description,
      String state,
      String address,
      String deliveryTime,
      String whatsapp,
      String facebook,
      String instagram,
      String bankAccount,
      String interbankAccount,
      String profilePhoto,
      String profileTitle) async {
    final data = {
      "description": description,
      "state": state,
      "address": address,
      "deliveryTime": deliveryTime,
      "whatsapp": int.parse(whatsapp),
      "social": [
        {"name": facebook ?? ""},
        {"name": instagram ?? ""}
      ],
      "bankAccount": bankAccount,
      "interbankAccount": interbankAccount,
      "profilePhoto": profilePhoto ?? "",
      "profileTitle": profileTitle ?? ""
    };

    final token = await _preferencesRepository.getData('token');
    print(token);
    final resp = await _dio.post(_shopCreate,
        data: data,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ));
    print(resp.data);
    if (resp.data['ok'] == true) {
      return true;
    } else {
      return false;
    }
  }

  Future updateShop(File profilePhoto, File profileTitle) async {
    final token = await _preferencesRepository.getData('token');

    FormData data = FormData.fromMap({
      "profilePhoto": await MultipartFile.fromFile(profilePhoto.path) ?? "",
      "profileTitle": await MultipartFile.fromFile(profileTitle.path) ?? ""
    });
    final resp = await _dio.put(_shopUpdate,
        data: data,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ));
    print(resp.data);
    if (resp.data['ok'] == true) {
      return true;
    } else
      return false;
  }

  Future getShopInfo() async {
    final token = await _preferencesRepository.getData('token');
    final resp = await _dio.get(_shopInfo,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
    if (resp.data['ok'] == true) {
      final shop = ShopResponse.fromJson(resp.data);
      return [true, shop];
    } else {
      return [false, null];
    }
  }
}
