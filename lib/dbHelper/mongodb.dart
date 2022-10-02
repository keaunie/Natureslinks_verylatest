import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/constant.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create("mongodb+srv://natureslink:nSlUa1XZ2EliU9KK@"
        "cluster0.c11zlq8.mongodb.net/?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    userCollection = db.collection("users");
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
