import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/CreateProduct/create_product.dart';
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
      List imageProduct) async {
    final data = {
      "name": name,
      "description": description,
      "productCategory": {
        "category": category.index,
        "subcategory": subcategory.index
      },
      "stockType": stockType,
      "stock": stock,
      "priceType": priceType,
      "price": {
        "normalPrice": int.parse(normalPrice),
        "offertPrice": int.parse(offerPrice),
      },
      "imageProduct": imageProduct
    };

    final token = await _preferencesRepository.getData('token');
    final resp = await _dio.post(_createProduct,
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
}
