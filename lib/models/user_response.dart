// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    UserResponse({
        this.ok,
        this.user,
        this.token,
    });

    bool ok;
    User user;
    String token;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        ok: json["ok"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    User({
        this.id,
        this.firstname,
        this.lastname,
        this.password,
        this.email,
        this.identifier,
        this.cellphone,
        this.role,
        this.shopName,
        this.resetPingUsed,
        this.resetPwdPing,
        this.resetPwdToken,
        this.v,
    });

    String id;
    String firstname;
    String lastname;
    String password;
    String email;
    int identifier;
    int cellphone;
    int role;
    String shopName;
    bool resetPingUsed;
    String resetPwdPing;
    String resetPwdToken;
    int v;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        password: json["password"],
        email: json["email"],
        identifier: json["identifier"],
        cellphone: json["cellphone"],
        role: json["role"],
        shopName: json["shopName"],
        resetPingUsed: json["resetPingUsed"],
        resetPwdPing: json["resetPwdPing"],
        resetPwdToken: json["resetPwdToken"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "email": email,
        "identifier": identifier,
        "cellphone": cellphone,
        "role": role,
        "shopName": shopName,
        "resetPingUsed": resetPingUsed,
        "resetPwdPing": resetPwdPing,
        "resetPwdToken": resetPwdToken,
        "__v": v,
    };
}
