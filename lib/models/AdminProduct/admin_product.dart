import 'package:flutter/cupertino.dart';
import 'package:service_products_business/helpers/enums.dart';

class AdminProduct {
  AdminColorType adminColorType;
  TextEditingController stock;
  List<SizeProduct> sizeProduct;

  AdminProduct(
      {this.adminColorType,
      TextEditingController stock,
      List<SizeProduct> sizeProduct})
      : this.stock = (stock == null) ? TextEditingController() : stock,
        this.sizeProduct =
            (sizeProduct == null) ? [SizeProduct()] : sizeProduct;

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
}
