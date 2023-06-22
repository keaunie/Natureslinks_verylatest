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
    required this.profilepic,
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
  String profilepic;
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
        profilepic: json["profilepic"],
        address: json["address"],
        contactNo: json["contactno"],
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
        "profilepic": profilepic,
        "address": address,
        "contactno": contactNo,
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
    required this.overview,
  });

  String link;
  String title;
  String overview;

  factory videoTutModel.fromJson(Map<String, dynamic> json) => videoTutModel(
        link: json["videoLink"],
        title: json["title"],
        overview: json["overview"],
      );

  Map<String, dynamic> toJson() => {
        "videoLink": link,
        "title": title,
        "overview": overview,
      };
}

appointmentModel appointmentModelFromJson(String str) =>
    appointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(appointmentModel data) =>
    json.encode(data.toJson());

class appointmentModel {
  appointmentModel({
    required this.id,
    required this.duid,
    required this.uid,
    required this.title,
    required this.email,
    required this.service,
    required this.approver,
    required this.patient,
    required this.date,
    required this.appointmentTime,
    required this.backgroundColor,
    required this.status,
    required this.postDate,
  });

  Object id;
  String duid;
  String uid;
  String title;
  String email;
  String service;
  String approver;
  String patient;
  String date;
  String appointmentTime;
  String backgroundColor;
  String status;
  DateTime postDate;

  factory appointmentModel.fromJson(Map<String, dynamic> json) =>
      appointmentModel(
          id: json["_id"],
          duid: json["duid"],
          uid: json["uid"],
          title: json["title"],
          email: json["email"],
          service: json["service"],
          approver: json["approver"],
          patient: json["patient"],
          date: json["date"],
          appointmentTime: json["appointmentTime"],
          backgroundColor: json["backgroundColor"],
          status: json["status"],
          postDate: json["postDate"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "duid": duid,
        "uid": uid,
        "title": title,
        "email": email,
        "service": service,
        "approver": approver,
        "patient": patient,
        "date": date,
        "appointmentTime": appointmentTime,
        "backgroundColor": backgroundColor,
        "status": status,
        "postDate": postDate,
      };
}

customerSupportModel customerSupportModelFromJson(String str) =>
    customerSupportModel.fromJson(json.decode(str));

String customerSuptoJson(customerSupportModel data) =>
    json.encode(data.toJson());

class customerSupportModel {
  customerSupportModel(
      {required this.supId,
      required this.title,
      required this.description,
      required this.uname,
      required this.uid});

  ObjectId supId;
  String title;
  String description;
  String uname;
  ObjectId uid;

  factory customerSupportModel.fromJson(Map<String, dynamic> json) =>
      customerSupportModel(
        supId: json["supId"],
        title: json["title"],
        description: json["description"],
        uname: json["uname"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "supId": supId,
        "title": title,
        "description": description,
        "uname": uname,
        "uid": uid,
      };
}

announcementModel announcementModelFromJson(String str) =>
    announcementModel.fromJson(json.decode(str));

String announcetoJson(customerSupportModel data) => json.encode(data.toJson());

class announcementModel {
  announcementModel({
    required this.title,
    required this.article,
    required this.authorname,
    required this.authoremail,
    required this.update,
    required this.postDate,
    required this.updatedBy,
  });

  String title;
  String article;
  String authorname;
  String authoremail;
  String update;
  String postDate;
  String updatedBy;

  factory announcementModel.fromJson(Map<String, dynamic> json) =>
      announcementModel(
          title: json["title"],
          article: json["article"],
          authorname: json["authorname"],
          authoremail: json["authoremail"],
          update: json["update"],
          postDate: json["authoremail"],
          updatedBy: json["updatedBy"]);

  Map<String, dynamic> toJson() => {
    "title": title,
    "article": article,
    "authorname": authorname,
    "authoremail": authoremail,
    "update": update,
    "postDate": postDate,
    "updatedBy": updatedBy,
  };
}
