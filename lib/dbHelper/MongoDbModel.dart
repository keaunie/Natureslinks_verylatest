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
    this.id,
    required this.email,
    required this.userName,
    required this.password,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address,
    required this.contactNo,
    required this.birthday,
    required this.gender,
    required this.religion,
    required this.civilStatus,
    required this.role,
  });
  ObjectId? id;
  String email;
  String userName;
  String password;
  String firstName;
  String middleName;
  String lastName;
  String address;
  String contactNo;
  String birthday;
  String gender;
  String religion;
  String civilStatus;
  String role;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    id: json["_id"],
    email: json["email"],
    userName: json["user"],
    password: json["pass"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    address: json["address"],
    contactNo: json["contactNo"],
    birthday: json["birthday"],
    gender: json["gender"],
    religion: json["religion"],
    civilStatus: json["civilStatus"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "user": userName,
    "pass": password,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "address": address,
    "contactNo": contactNo,
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

appointmentModel appointmentModelFromJson(String str) =>
    appointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(videoTutModel data) => json.encode(data.toJson());

class appointmentModel {
  appointmentModel({
    required this.duid,
    required this.uid,
    required this.patient,
    required this.date,
    required this.time,
    required this.doctor,
    required this.status,
  });

  ObjectId duid;
  ObjectId uid;
  String patient;
  String date;
  String time;
  String doctor;
  String status;

  factory appointmentModel.fromJson(Map<String, dynamic> json) => appointmentModel(
    duid: json["duid"],
    uid: json["uid"],
    patient: json["patient"],
    date: json["date"],
    time: json["time"],
    doctor: json["doctor"],
    status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "duid": duid,
    "uid": uid,
    "patient": patient,
    "date": date,
    "time": time,
    "doctor": doctor,
    "status": status,
  };
}
