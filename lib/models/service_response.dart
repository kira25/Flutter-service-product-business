// To parse this JSON data, do
//
//     final serviceResponse = serviceResponseFromJson(jsonString);

import 'dart:convert';

ServiceResponse serviceResponseFromJson(String str) =>
    ServiceResponse.fromJson(json.decode(str));

String serviceResponseToJson(ServiceResponse data) =>
    json.encode(data.toJson());

class ServiceResponse {
  ServiceResponse({
    this.ok,
    this.service,
  });

  bool ok;
  List<Service> service;

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      ServiceResponse(
        ok: json["ok"],
        service:
            List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "service": List<dynamic>.from(service.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.location,
    this.price,
    this.id,
    this.name,
    this.description,
    this.deliveryTime,
    this.attentionHours,
    this.availableType,
    this.address,
    this.districtAvailable,
    this.imageService,
    this.userId,
    this.isAvailable,
    this.createdAt,
    this.v,
  });

  Location location;
  Price price;
  String id;
  String name;
  String description;
  String deliveryTime;
  String attentionHours;
  int availableType;
  String address;
  List<DistrictAvailable> districtAvailable;
  List<ImageService> imageService;
  String userId;
  bool isAvailable;
  DateTime createdAt;
  int v;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        location: json["location"] == null
            ? Location()
            : Location.fromJson(json["location"]),
        price: Price.fromJson(json["price"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        deliveryTime: json["deliveryTime"],
        attentionHours: json["attentionHours"],
        availableType: json["availableType"],
        address: json["address"],
        districtAvailable: List<DistrictAvailable>.from(
            json["districtAvailable"]
                .map((x) => DistrictAvailable.fromJson(x))),
        imageService: List<ImageService>.from(
            json["imageService"].map((x) => ImageService.fromJson(x))),
        userId: json["userId"],
        isAvailable: json["isAvailable"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "price": price.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "deliveryTime": deliveryTime,
        "attentionHours": attentionHours,
        "availableType": availableType,
        "address": address,
        "districtAvailable":
            List<dynamic>.from(districtAvailable.map((x) => x.toJson())),
        "imageService": List<dynamic>.from(imageService.map((x) => x.toJson())),
        "userId": userId,
        "isAvailable": isAvailable,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class DistrictAvailable {
  DistrictAvailable({
    this.id,
    this.district,
  });

  String id;
  int district;

  factory DistrictAvailable.fromJson(Map<String, dynamic> json) =>
      DistrictAvailable(
        id: json["_id"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "district": district,
      };
}

class ImageService {
  ImageService({
    this.id,
    this.service,
  });

  String id;
  String service;

  factory ImageService.fromJson(Map<String, dynamic> json) => ImageService(
        id: json["_id"],
        service: json["service"] == null ? null : json["service"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "service": service == null ? null : service,
      };
}

class Location {
  Location({
    this.department,
    this.city,
    this.district,
  });

  int department;
  int city;
  int district;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        department: json["department"],
        city: json["city"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "department": department,
        "city": city,
        "district": district,
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
        offertPrice: json["offertPrice"],
      );

  Map<String, dynamic> toJson() => {
        "normalPrice": normalPrice,
        "offertPrice": offertPrice,
      };
}
