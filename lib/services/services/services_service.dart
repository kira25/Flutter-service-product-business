import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/service_response.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';

class ServicesService {
  ServicesService._privateConstructor();
  static final ServicesService _instance =
      ServicesService._privateConstructor();

  factory ServicesService() {
    return _instance;
  }

  final PreferencesRepository _preferencesRepository = PreferencesRepository();

  final _dio = new Dio();

  final _createService = '${Environment.apiUrl}/service/create';
  final _getServiceByUser = '${Environment.apiUrl}/service/user';
  final _addServiceImages = '${Environment.apiUrl}/service/imageService';
  final _updateService = '${Environment.apiUrl}/service/update';
  final _deleteService = '${Environment.apiUrl}/service/delete';

  Future createService(
      String name,
      String description,
      String deliveryTime,
      String attentionHours,
      AvailableType availableType,
      DepartmentType departmentType,
      ProvinceType provinceType,
      DistrictType districtType,
      String address,
      List districtAvailables,
      PriceType priceType,
      String normalPrice,
      String offerPrice,
      List<File> filesImages) async {
    final data = {
      "name": name,
      "description": description,
      "deliveryTime": deliveryTime,
      "attentionHours": attentionHours,
      "availableType": availableType.index,
      "location": {
        "department": departmentType.index ?? null,
        "city": provinceType.index ?? null,
        "district": districtType.index ?? null
      },
      "address": address ?? null,
      "districtAvailable": districtAvailables ?? [],
      "priceType": priceType.index,
      "price": {"normalPrice": normalPrice, "offertPrice": offerPrice}
    };

    final token = await _preferencesRepository.getData('token');

    final resp = await _dio.post(_createService,
        data: data,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ));

    if (resp.data['ok'] == true) {
      FormData dataImages = FormData.fromMap({
        "imageService1": filesImages.length > 0
            ? await MultipartFile.fromFile(filesImages[0].path)
            : null,
        "imageService2": filesImages.length > 1
            ? await MultipartFile.fromFile(filesImages[1].path)
            : null,
        "imageService3": filesImages.length > 2
            ? await MultipartFile.fromFile(filesImages[2].path)
            : null,
        "imageService4": filesImages.length > 3
            ? await MultipartFile.fromFile(filesImages[3].path)
            : null,
        "imageService5": filesImages.length > 4
            ? await MultipartFile.fromFile(filesImages[4].path)
            : null,
      });
      final respImages = await _dio.put('$_addServiceImages',
          queryParameters: {"serviceId": resp.data['newService']['_id']},
          data: dataImages,
          options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          ));
      if (respImages.data['ok'] == true) {
        print(respImages.data);
        return true;
      } else {
        print('error updated');
        return false;
      }
    } else {
      return false;
    }
  }

  Future getServiceByUser() async {
    final token = await _preferencesRepository.getData('token');
    final resp = await _dio.get(_getServiceByUser,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
    print('services:  ${resp.data}');
    if (resp.data['ok'] == true) {
      final products = ServiceResponse.fromJson(resp.data);

      return [true, products];
    } else {
      return [false, null];
    }
  }

  Future deleteService(String id) async {
    final token = await _preferencesRepository.getData('token');

    final resp = await _dio.delete(_deleteService,
        queryParameters: {"serviceId": id},
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
    print('deleted : ${resp.data}');
    if (resp.data['ok'] == true) {
      return true;
    } else {
      return false;
    }
  }

  //TODO: UPDATE SERVICE

  Future updateService(
      String deliveryTime,
      String attentionHours,
      AvailableType availableType,
      DepartmentType departmentType,
      ProvinceType provinceType,
      DistrictType districtType,
      String address,
      List districtAvailables,
      PriceType priceType,
      String normalPrice,
      String offerPrice,
      String id) async {
    final token = await _preferencesRepository.getData('token');
    var data;
    if (availableType == AvailableType.HOME) {
      data = {
        "deliveryTime": deliveryTime,
        "attentionHours": attentionHours,
        "availableType": availableType.index,
        "districtAvailable": districtAvailables ?? [],
        "priceType": priceType.index,
        "price": {"normalPrice": normalPrice, "offertPrice": offerPrice}
      };
    } else if (availableType == AvailableType.SHOP_HOME) {
      data = {
        "deliveryTime": deliveryTime,
        "attentionHours": attentionHours,
        "availableType": availableType.index,
        "location": {
          "department": departmentType.index ?? null,
          "city": provinceType.index ?? null,
          "district": districtType.index ?? null
        },
        "address": address ?? null,
        "districtAvailable": districtAvailables ?? [],
        "priceType": priceType.index,
        "price": {"normalPrice": normalPrice, "offertPrice": offerPrice}
      };
    } else {
      data = {
        "deliveryTime": deliveryTime,
        "attentionHours": attentionHours,
        "availableType": availableType.index,
        "location": {
          "department": departmentType.index ?? null,
          "city": provinceType.index ?? null,
          "district": districtType.index ?? null
        },
        "address": address ?? null,
        "priceType": priceType.index,
        "price": {"normalPrice": normalPrice, "offertPrice": offerPrice}
      };
    }

    final resp = await _dio.put(_updateService,
        data: data,
        queryParameters: {"serviceId": id},
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));

    if (resp.data['ok'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
