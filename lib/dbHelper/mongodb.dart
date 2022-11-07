import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/constant.dart';

class MongoDatabase {
  static var db, userCollection;

  // static Future<List<Map<String, dynamic>>> getData() async {
  //   final arrData = await MongoDatabase.userCollection.find().toList();
  //   return arrData;
  // }

  static connect() async {
    db = await Db.create(
        "mongodb+srv://natureslinkmobileapp:0woy4h1iUFwOIKOj@cluster0.0u1vd.mongodb.net/?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    userCollection = db.collection("mobileusers");
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong with data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}

class videoTutorial {
  static var dbs, videoTutCollection;

  static connectVT() async {
    dbs = await Db.create(
        "mongodb+srv://natureslinkmobileapp:0woy4h1iUFwOIKOj@cluster0.0u1vd.mongodb.net/?retryWrites=true&w=majority");
    await dbs.open();
    inspect(dbs);
    videoTutCollection = dbs.collection("videoTutorials");
  }

  static Future<String> insertVT(videoTutModel data) async {
    try {
      var result = await videoTutCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong with data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}

class chatAppointments {
  static var dbc, chatAppointCollection;

  static connectCA() async {
    dbc = await Db.create(
        "mongodb+srv://natureslinkmobileapp:0woy4h1iUFwOIKOj@cluster0.0u1vd.mongodb.net/?retryWrites=true&w=majority");
    await dbc.open();
    inspect(dbc);
    chatAppointCollection = dbc.collection("chatAppointments");
  }

  static Future<String> insertCA(appointmentModel data) async {
    try {
      var result = await chatAppointCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong with data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
