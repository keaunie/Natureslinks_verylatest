// To parse this JSON data, do
//
//    final mongoDbModel = mongoDbModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address,
    required this.birthday,
    required this.gender,
    required this.religion,
    required this.civilStatus,
    required this.role,
  });

  String email;
  String userName;
  String password;
  String firstName;
  String middleName;
  String lastName;
  String address;
  String birthday;
  String gender;
  String religion;
  String civilStatus;
  String role;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    email: json["email"],
    userName: json["user"],
    password: json["pass"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    address: json["address"],
    birthday: json["birthday"],
    gender: json["gender"],
    religion: json["religion"],
    civilStatus: json["civilStatus"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "user": userName,
    "pass": password,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "address": address,
    "birthday": birthday,
    "gender": gender,
    "religion": religion,
    "civilStatus": civilStatus,
    "role": role,
  };
}


videoTutModel vidTutmodelFromJson(String str) =>
    videoTutModel.fromJson(json.decode(str));

String vidTutmodeltoJson(videoTutModel data) => json.encode(data.toJson());

class videoTutModel {
  videoTutModel({
    required this.link,
    required this.title,
    required this.description,
  });

  String link;
  String title;
  String description;

  factory videoTutModel.fromJson(Map<String, dynamic> json) => videoTutModel(
    link: json["link"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "title": title,
    "description": description,
  };
}
