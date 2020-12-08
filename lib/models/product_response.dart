// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.ok,
    this.product,
  });

  bool ok;
  List<Product> product;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        ok: json["ok"],
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class Product {
  Product(
      {this.productCategory,
      this.price,
      this.id,
      this.name,
      this.description,
      this.stockType,
      this.stock,
      this.priceType,
      this.imageProduct,
      this.userId,
      this.createdAt,
      this.v,
      this.amountStock});

  ShopProductCategory productCategory;
  Price price;
  String id;
  String name;
  String description;
  int stockType;
  List<Stock> stock;
  int priceType;
  List<ImageProduct> imageProduct;
  String userId;
  DateTime createdAt;
  int amountStock;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      productCategory: ShopProductCategory.fromJson(json["productCategory"]),
      price: Price.fromJson(json["price"]),
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      stockType: json["stockType"],
      stock: List<Stock>.from(json["stock"].map((x) => Stock.fromJson(x))),
      priceType: json["priceType"],
      imageProduct: List<ImageProduct>.from(
          json["imageProduct"].map((x) => ImageProduct.fromJson(x))),
      userId: json["userId"],
      createdAt: DateTime.parse(json["createdAt"]),
      v: json["__v"],
      amountStock: json["amountStock"]);

  Map<String, dynamic> toJson() => {
        "productCategory": productCategory.toJson(),
        "price": price.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "stockType": stockType,
        "stock": List<dynamic>.from(stock.map((x) => x.toJson())),
        "priceType": priceType,
        "imageProduct": List<dynamic>.from(imageProduct.map((x) => x.toJson())),
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "amountStock": amountStock
      };
}

class ImageProduct {
  ImageProduct({
    this.id,
    this.product,
  });

  String id;
  String product;

  factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
        id: json["_id"] ?? null,
        product: json["product"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product,
      };
}

class Price {
  Price({
    this.normalPrice,
    this.offertPrice,
  });

  int normalPrice;
  int offertPrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        normalPrice: json["normalPrice"],
        offertPrice: json["offertPrice"] == null ? null : json["offertPrice"],
      );

  Map<String, dynamic> toJson() => {
        "normalPrice": normalPrice,
        "offertPrice": offertPrice == null ? null : offertPrice,
      };
}

class ShopProductCategory {
  ShopProductCategory({
    this.category,
    this.subcategory,
  });

  int category;
  int subcategory;

  factory ShopProductCategory.fromJson(Map<String, dynamic> json) =>
      ShopProductCategory(
        category: json["category"],
        subcategory: json["subcategory"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "subcategory": subcategory,
      };
}

class Stock {
  Stock({
    this.sizeProduct,
    this.id,
    this.quantity,
    this.color,
  });

  List<ShopSizeProduct> sizeProduct;
  String id;
  int quantity;
  int color;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        sizeProduct: List<ShopSizeProduct>.from(
            json["sizeProduct"].map((x) => ShopSizeProduct.fromJson(x))),
        id: json["_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        color: json["color"] == null ? null : json["color"],
      );

  Map<String, dynamic> toJson() => {
        "sizeProduct": List<dynamic>.from(sizeProduct.map((x) => x.toJson())),
        "_id": id,
        "quantity": quantity == null ? null : quantity,
        "color": color == null ? null : color,
      };
}

class ShopSizeProduct {
  ShopSizeProduct({
    this.id,
    this.size,
    this.sizeQuantity,
  });

  String id;
  int size;
  int sizeQuantity;

  factory ShopSizeProduct.fromJson(Map<String, dynamic> json) =>
      ShopSizeProduct(
        id: json["_id"],
        size: json["size"],
        sizeQuantity: json["sizeQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "size": size,
        "sizeQuantity": sizeQuantity,
      };
}
