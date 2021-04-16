import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_products_business/global/environment.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';

class OrderProductService {
  OrderProductService._privateConstructor();

  static final OrderProductService _instance =
  OrderProductService._privateConstructor();

  factory OrderProductService() {
    return _instance;
  }

  final PreferencesRepository _preferencesRepository = PreferencesRepository();
  final _dio = new Dio();

  final _getOrderProductUser =
      '${Environment.apiUrl}/orders-products/userOrders';
  final _updateOrderProductStage =
      '${Environment.apiUrl}/orders-products/updateOrder';

  Future updateOrderProductStage(List<SelectedProducts> list, int orderStage,
      id,{int deliveryType}) async {
    final token = await _preferencesRepository.getData('token');
    final selectedProduct = list.map((e) => e.toJson()).toList();
    print(selectedProduct);
    try {
      final resp = await _dio.put(_updateOrderProductStage,
          queryParameters: {"orderProductID": id},
          options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          ),
          data: {
            "selectedProducts": selectedProduct,
            "orderState": orderStage,
            "deliveryType": deliveryType ?? null
          });
      print(resp);
      if (resp.data['ok'] == true) {

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error :$e');
      return e;

    }
  }

  Future getOrderProductUser() async {
    final token = await _preferencesRepository.getData('token');
    final resp = await _dio.get(_getOrderProductUser,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
    print('orders:  ${resp.data}');
    if (resp.data['ok'] == true) {
      final List<OrderProductResponse> orderProductUser =
      List<OrderProductResponse>.from(resp.data['orderProduct']
          .map((x) => OrderProductResponse.fromJson(x)));

      return orderProductUser;
    } else {
      return null;
    }
  }
}
