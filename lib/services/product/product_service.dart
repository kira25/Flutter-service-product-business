import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';

class ProductService {
  ProductService._privateConstructor();
  static final ProductService _instance = ProductService._privateConstructor();

  factory ProductService() {
    return _instance;
  }

  final PreferencesRepository _preferencesRepository = PreferencesRepository();

  final _dio = new Dio();

  final _createProduct = '${Environment.apiUrl}/products/create';
  final _getProductByUser = '${Environment.apiUrl}/products/user';
  final _addProductImages = '${Environment.apiUrl}/products/imageProduct/';

  Future createProduct(
      String name,
      String description,
      ProductCategory category,
      ProductSubCategory subcategory,
      int stockType,
      List stock,
      int priceType,
      String normalPrice,
      String offerPrice,
      List imageProduct,
      List<File> filesProduct) async {
    final data = {
      "name": name,
      "description": description,
      "productCategory": {
        "category": category.index,
        "subcategory": subcategory.index,
      },
      "stockType": stockType,
      "stock": stock,
      "priceType": priceType,
      "price": {
        "normalPrice": int.parse(normalPrice),
        "offertPrice": offerPrice != null ? int.parse(offerPrice) : null,
      },
      "imageProduct": []
    };

    final token = await _preferencesRepository.getData('token');
    print('creating product');
    final resp = await _dio.post(_createProduct,
        data: data,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ));

    print(resp.data);
    if (resp.data['ok'] == true) {
      print(resp.data['newProduct']['_id']);

      FormData dataImages = FormData.fromMap({
        "imageProduct1": filesProduct.length > 0
            ? await MultipartFile.fromFile(filesProduct[0].path)
            : null,
        "imageProduct2": filesProduct.length > 1
            ? await MultipartFile.fromFile(filesProduct[1].path)
            : null,
        "imageProduct3": filesProduct.length > 2
            ? await MultipartFile.fromFile(filesProduct[2].path)
            : null,
        "imageProduct4": filesProduct.length > 3
            ? await MultipartFile.fromFile(filesProduct[3].path)
            : null,
        "imageProduct5": filesProduct.length > 4
            ? await MultipartFile.fromFile(filesProduct[4].path)
            : null,
      });
      print('add images');
      final respImages =
          await _dio.put('$_addProductImages${resp.data['newProduct']['_id']}',
              data: dataImages,
              options: Options(
                headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
              ));
      if (respImages.data['ok'] == true) {
        print(respImages.data);
        return true;
      } else {
        print('error updated');
        return true;
      }
    } else {
      print('error create');
      return false;
    }
  }

  Future getProductByUser() async {
    final token = await _preferencesRepository.getData('token');
    final resp = await _dio.get(_getProductByUser,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
    if (resp.data['ok'] == true) {
      final products = ProductResponse.fromJson(resp.data);
      print(resp.data);
      print(products);
      return [true, products];
    } else {
      return [false, null];
    }
  }

  Future addProductImages(
    File imageProduct1,
    File imageProduct2,
    File imageProduct3,
    File imageProduct4,
    File imageProduct5,
  ) async {
    final token = await _preferencesRepository.getData('token');
    FormData data = FormData.fromMap({
      "imageProduct1": await MultipartFile.fromFile(imageProduct1.path) ?? "",
      "imageProduct2": await MultipartFile.fromFile(imageProduct2.path) ?? "",
      "imageProduct3": await MultipartFile.fromFile(imageProduct3.path) ?? "",
      "imageProduct4": await MultipartFile.fromFile(imageProduct4.path) ?? "",
      "imageProduct5": await MultipartFile.fromFile(imageProduct5.path) ?? ""
    });

    final resp = await _dio.put('$_addProductImages/',
        data: data,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ));
  }
}
