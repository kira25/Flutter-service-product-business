import 'package:flutter/cupertino.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';

class AdminProduct {
  AdminColorType adminColorType;
  TextEditingController stock;
  List<SizeProduct> sizeProduct;
  String id;

  AdminProduct(
      {this.id,
      this.adminColorType,
      TextEditingController stock,
      List<SizeProduct> sizeProduct})
      : this.stock = (stock == null) ? TextEditingController() : stock,
        this.sizeProduct =
            (sizeProduct == null) ? [SizeProduct()] : sizeProduct;

  factory AdminProduct.fromJsonAdmin(Map<String, dynamic> json) => AdminProduct(
      adminColorType: json["color"] == null
          ? null
          : handleIntToAdminColorType(json["color"]),
      id: json["_id"] == null ? null : json["_id"],
      sizeProduct: json["sizeProduct"] == null
          ? null
          : List<SizeProduct>.from(
              json["sizeProduct"].map((x) => SizeProduct.fromJson(x))),
      stock: json["quantity"] == null
          ? TextEditingController(text: "")
          : TextEditingController(text: json["quantity"].toString()));

  Map<String, dynamic> toJsonUnique() =>
      {"quantity": int.parse(stock.text) ?? "", "sizeProduct": []};

  Map<String, dynamic> toJsonSize() => {
        "sizeProduct": List<dynamic>.from(sizeProduct.map((x) => x.toJson())),
      };

  Map<String, dynamic> toJsonColor() => {
        "color": adminColorType.index,
        "quantity": int.parse(stock.text) ?? "",
        "sizeProduct": []
      };

  Map<String, dynamic> toJsonSizeColor() => {
        "color": adminColorType.index,
        "sizeProduct": List<dynamic>.from(sizeProduct.map((x) => x.toJson()))
      };
}

class SizeProduct {
  Sizes size;
  TextEditingController sizeStock;

  SizeProduct({this.size, TextEditingController sizeStock})
      : this.sizeStock =
            (sizeStock == null) ? TextEditingController() : sizeStock;

  Map<String, dynamic> toJson() => {
        "size": size.index,
        "sizeQuantity": int.parse(sizeStock.text),
      };

  factory SizeProduct.fromJson(Map<String, dynamic> json) => SizeProduct(
      size: json["size"] == null ? null : handleResponseToSize(json["size"]),
      sizeStock: json["sizeQuantity"] == null
          ? null
          : TextEditingController(text: json["sizeQuantity"].toString()));
}
