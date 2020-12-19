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
  final _updateProduct = '${Environment.apiUrl}/products/update/';
  final _deleteProduct = '${Environment.apiUrl}/products/delete';

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
        return false;
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

  Future updateProduct(
    String id,
    int stockType,
    List stock,
    int priceType,
    String normalPrice,
    String offerPrice,
  ) async {
    final token = await _preferencesRepository.getData('token');

    final data = {
      "stockType": stockType,
      "stock": stock,
      "priceType": priceType,
      "price": {
        "normalPrice": int.parse(normalPrice),
        "offertPrice": offerPrice != null && offerPrice.isNotEmpty ? int.parse(offerPrice) : null,
      },
    };
    final resp = await _dio.put('$_updateProduct$id',
        data: data,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ));
    if (resp.data['ok'] == true) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteProduct(String id) async {
    final resp =
        await _dio.delete(_deleteProduct, queryParameters: {"productID": id});
    if (resp.data['ok'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
