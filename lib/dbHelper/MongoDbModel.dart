
// To parse this JSON data, do
//
//    final mongoDbModel = mongoDbModelFromJson(jsonString);

// ignore_for_file: file_names


import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel{
  MongoDbModel({
    required this.uid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address,
    required this.birthday,
    required this.gender,
    required this.religion,
    required this.civilStatus,
});

  ObjectId uid;
  String firstName;
  String middleName;
  String lastName;
  String address;
  String birthday;
  String gender;
  String religion;
  String civilStatus;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    uid: json["_uid"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    address: json["address"],
    birthday: json["birthday"],
    gender: json["gender"],
    religion: json["religion"],
    civilStatus: json["civilStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_uid": uid,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "address": address,
    "birthday": birthday,
    "gender": gender,
    "religion": religion,
    "civilStatus": civilStatus,
  };

}