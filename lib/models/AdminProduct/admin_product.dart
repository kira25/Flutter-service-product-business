import 'package:flutter/cupertino.dart';
import 'package:service_products_business/helpers/enums.dart';

class AdminProduct {
  AdminColorType adminColorType;
  TextEditingController stock;

  AdminProduct({this.adminColorType, TextEditingController stock})
      : this.stock = (stock == null) ? TextEditingController() : stock;

  Map<String, dynamic> toJson() =>
      {"color": adminColorType.index, "quantity": int.parse(stock.text)};
}
