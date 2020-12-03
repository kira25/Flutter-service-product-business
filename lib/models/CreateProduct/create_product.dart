// import 'package:flutter/material.dart';

// // To parse this JSON data, do
// //
// //     final createProduct = createProductFromJson(jsonString);

// import 'dart:convert';

// CreateProduct createProductFromJson(String str) =>
//     CreateProduct.fromJson(json.decode(str));

// String createProductToJson(CreateProduct data) => json.encode(data.toJson());

// class CreateProduct {
//   CreateProduct({
//     this.name,
//     this.description,
//     this.productCategory,
//     this.stockType,
//     this.stock,
//     this.priceType,
//     this.price,
//     this.imageProduct,
//   });

//   String name;
//   String description;
//   ProductCategory productCategory;
//   int stockType;
//   List<Stock> stock;
//   int priceType;
//   Price price;
//   List<ImageProduct> imageProduct;
 
 

//   factory CreateProduct.fromJson(Map<String, dynamic> json) => CreateProduct(
//         name: json["name"],
//         description: json["description"],
//         productCategory: ProductCategory.fromJson(json["productCategory"]),
//         stockType: json["stockType"],
//         stock: List<Stock>.from(json["stock"].map((x) => Stock.fromJson(x))),
//         priceType: json["priceType"],
//         price: Price.fromJson(json["price"]),
//         imageProduct: List<ImageProduct>.from(
//             json["imageProduct"].map((x) => ImageProduct.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "productCategory": productCategory.toJson(),
//         "stockType": stockType,
//         "stock": List<dynamic>.from(stock.map((x) => x.toJson())),
//         "priceType": priceType,
//         "price": price.toJson(),
//         "imageProduct": List<dynamic>.from(imageProduct.map((x) => x.toJson())),
   
      
//       };
// }

// class ImageProduct {
//   ImageProduct({
//     this.id,
//     this.product,
//   });

//   String id;
//   String product;

//   factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
//         id: json["_id"],
//         product: json["product"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "product": product,
//       };
// }

// class Price {
//   Price({
//     this.normalPrice,
//     this.offertPrice,
//   });

//   int normalPrice;
//   int offertPrice;

//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//         normalPrice: json["normalPrice"],
//         offertPrice: json["offertPrice"],
//       );

//   Map<String, dynamic> toJson() => {
//         "normalPrice": normalPrice,
//         "offertPrice": offertPrice,
//       };
// }

// class ProductCategory {
//   ProductCategory({
//     this.category,
//     this.subcategory,
//   });

//   int category;
//   int subcategory;

//   factory ProductCategory.fromJson(Map<String, dynamic> json) =>
//       ProductCategory(
//         category: json["category"],
//         subcategory: json["subcategory"],
//       );

//   Map<String, dynamic> toJson() => {
//         "category": category,
//         "subcategory": subcategory,
//       };
// }

// class Stock {
//   Stock({
//     this.id,
//     this.color,
//   });

//   String id;
//   int color;

//   factory Stock.fromJson(Map<String, dynamic> json) => Stock(
//         id: json["_id"],
//         color: json["color"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "color": color,
//       };
// }
