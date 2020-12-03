// To parse this JSON data, do
//
//     final shopResponse = shopResponseFromJson(jsonString);

import 'dart:convert';

ShopResponse shopResponseFromJson(String str) =>
    ShopResponse.fromJson(json.decode(str));

String shopResponseToJson(ShopResponse data) => json.encode(data.toJson());

class ShopResponse {
  ShopResponse({
    this.ok,
    this.shop,
  });

  bool ok;
  Shop shop;

  factory ShopResponse.fromJson(Map<String, dynamic> json) => ShopResponse(
        ok: json["ok"],
        shop: Shop.fromJson(json["shop"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "shop": shop.toJson(),
      };
}

class Shop {
  Shop({
    this.id,
    this.description,
    this.state,
    this.address,
    this.deliveryTime,
    this.whatsapp,
    this.social,
    this.bankAccount,
    this.interbankAccount,
    this.profilePhoto,
    this.profileTitle,
    this.userId,
    this.title = "",
    this.email = "",
    this.v,
  });

  String id;
  String description;
  String state;
  String address;
  String deliveryTime;
  int whatsapp;
  List<Social> social;
  String bankAccount;
  String interbankAccount;
  String profilePhoto;
  String profileTitle;
  String userId;
  String title;
  String email;
  int v;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["_id"],
        description: json["description"],
        state: json["state"],
        address: json["address"],
        deliveryTime: json["deliveryTime"],
        whatsapp: json["whatsapp"],
        social:
            List<Social>.from(json["social"].map((x) => Social.fromJson(x))),
        bankAccount: json["bankAccount"],
        interbankAccount: json["interbankAccount"],
        profilePhoto: json["profilePhoto"],
        profileTitle: json["profileTitle"],
        userId: json["userId"],
        title: json["title"],
        email: json["email"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "state": state,
        "address": address,
        "deliveryTime": deliveryTime,
        "whatsapp": whatsapp,
        "social": List<dynamic>.from(social.map((x) => x.toJson())),
        "bankAccount": bankAccount,
        "interbankAccount": interbankAccount,
        "profilePhoto": profilePhoto,
        "profileTitle": profileTitle,
        "userId": userId,
        "title": title,
        "email": email,
        "__v": v,
      };
}

class Social {
  Social({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
