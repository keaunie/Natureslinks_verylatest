import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/constant.dart';

class MongoDatabase {
  static var db, userCollection;


  static Future<List<Map<String, dynamic>>> getData() async{
    final arrData = await MongoDatabase.userCollection.find().toList();
    return arrData;
  }

  static connect() async {

    db = await Db.create("mongodb+srv://natureslinkmobileapp:3B7jcSPzbSUzJjlN@"
        "cluster0.0u1vd.mongodb.net/?retryWrites=true&w=majority");
    await db.open();
    inspect(db);
    userCollection = db.collection("bunnyusers");
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
