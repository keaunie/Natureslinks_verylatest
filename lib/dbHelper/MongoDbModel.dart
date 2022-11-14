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
    required this.overview,
  });

  String link;
  String title;
  String overview;

  factory videoTutModel.fromJson(Map<String, dynamic> json) => videoTutModel(
        link: json["link"],
        title: json["title"],
        overview: json["overview"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
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
    required this.patient,
    required this.date,
    required this.time,
    required this.doctor,
    required this.status,
  });

  Object id;
  ObjectId duid;
  ObjectId uid;
  String patient;
  String date;
  String time;
  String doctor;
  String status;

  factory appointmentModel.fromJson(Map<String, dynamic> json) =>
      appointmentModel(
          id: json["_id"],
          duid: json["duid"],
          uid: json["uid"],
          patient: json["patient"],
          date: json["date"],
          time: json["time"],
          doctor: json["doctor"],
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "duid": duid,
        "uid": uid,
        "patient": patient,
        "date": date,
        "time": time,
        "doctor": doctor,
        "status": status,
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
  });

  String title;
  String article;
  String authorname;
  String authoremail;
  String update;
  String postDate;

  factory announcementModel.fromJson(Map<String, dynamic> json) =>
      announcementModel(
        title: json["title"],
        article: json["article"],
        authorname: json["authorname"],
        authoremail: json["authoremail"],
        update: json["update"],
        postDate: json["authoremail"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "article": article,
        "authorname": authorname,
        "authoremail": authoremail,
        "update": update,
        "postDate": postDate,
      };
}
