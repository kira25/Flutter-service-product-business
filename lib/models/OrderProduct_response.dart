// To parse this JSON data, do
//
//     final orderProductResponse = orderProductResponseFromJson(jsonString);

import 'dart:convert';

OrderProductResponse orderProductResponseFromJson(String str) =>
    OrderProductResponse.fromJson(json.decode(str));

String orderProductResponseToJson(OrderProductResponse data) =>
    json.encode(data.toJson());

class OrderProductResponse {
  OrderProductResponse({this.id,
    this.sellerId,
    this.clientAddress,
    this.selectedProducts,
    this.orderId,
    this.clientId,
    this.clientName,
    this.clientCellphone,
    this.amountProducts,
    this.totalPrice,
    this.createdAt,
    this.orderState,
    this.v,
    this.deliveryType,
    this.deliveryId});

  String id;
  String sellerId;
  String clientAddress;
  List<SelectedProducts> selectedProducts;
  String orderId;
  String clientId;
  String clientName;
  String clientCellphone;
  int amountProducts;
  int orderState;
  int totalPrice;
  DateTime createdAt;
  int v;
  int deliveryType;
  String deliveryId;

  factory OrderProductResponse.fromJson(Map<String, dynamic> json) =>
      OrderProductResponse(
          id: json["_id"],
          sellerId: json["sellerId"],
          clientAddress: json["clientAddress"],
          selectedProducts: List<SelectedProducts>.from(json["selectedProducts"]
              .map((x) => SelectedProducts.fromJson(x))),
          orderId: json["orderId"],
          clientId: json["clientId"],
          clientName: json["clientName"],
          clientCellphone: json["clientCellphone"],
          amountProducts: json["amountProducts"],
          totalPrice: json["totalPrice"],
          createdAt: DateTime.parse(json["createdAt"]),
          orderState: json["orderState"],
          v: json["__v"],
          deliveryId: json["deliveryId"],
          deliveryType: json["deliveryType"]);

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "sellerId": sellerId,
        "clientAddress": clientAddress,
        "product": List<dynamic>.from(selectedProducts.map((x) => x.toJson())),
        "orderId": orderId,
        "clientId": clientId,
        "clientName": clientName,
        "clientCellphone": clientCellphone,
        "amountProducts": amountProducts,
        "totalPrice": totalPrice,
        "createdAt": createdAt.toIso8601String(),
        "orderState": orderState,
        "__v": v,
        "deliveryType": deliveryType,
        "deliveryId": deliveryId
      };
}

class SelectedProducts {
  SelectedProducts({this.id,
    this.amount,
    this.color,
    this.price,
    this.productId,
    this.size,
    this.accepted});

  String id;
  int amount;
  bool accepted;
  int color;
  int price;
  String productId;
  int size;

  factory SelectedProducts.fromJson(Map<String, dynamic> json) =>
      SelectedProducts(
          id: json["_id"],
          amount: json["amount"],
          color: json["color"] == null ? null : json["color"],
          price: json["price"],
          productId: json["productId"],
          size: json["size"] == null ? null : json["size"],
          accepted: json["accepted"]);

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "amount": amount,
        "accepted": accepted,
        "color": color == null ? null : color,
        "price": price,
        "productId": productId,
        "size": size == null ? null : size,
      };
}
