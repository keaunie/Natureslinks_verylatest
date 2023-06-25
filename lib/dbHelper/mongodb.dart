import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/constant.dart';
import 'package:natureslink/globals.dart' as globals;

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
    userCollection = db.collection("userdetails");
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

  static Future<String> uploadProfilep(String profilep) async {
    // print(profilep);

    var result = await userCollection.update(
        where.eq('email', globals.email), modify.set('profilepic', profilep));

    try {
      // print(globals.email);
      // print(result);
      return "Data Inserted";
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
    videoTutCollection = dbs.collection("guidelines");
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
    chatAppointCollection = dbc.collection("services");
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

  static Future<String> updateAppointment(Object id, String status) async {
    // print(profilep);

    var result = await chatAppointCollection.update(
        where.eq('_id', id), modify.set('status', status));

    try {
      // print(globals.email);
      // print(result);
      return "Data Inserted";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}

class customerSupport {
  static var dbcs, customerSupportCollection;

  static delete(customerSupportModel data) async {
    print(data.supId);
    await customerSupportCollection
        .deleteOne(<String, Object>{'supId': '${data.supId}'});
  }

  static connectCS() async {
    dbcs = await Db.create(
        "mongodb+srv://natureslinkmobileapp:0woy4h1iUFwOIKOj@cluster0.0u1vd.mongodb.net/?retryWrites=true&w=majority");
    await dbcs.open();
    inspect(dbcs);
    customerSupportCollection = dbcs.collection("customerSupports");
  }

  static Future<String> insertCS(customerSupportModel data) async {
    try {
      var result = await customerSupportCollection.insertOne(data.toJson());
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

class announcement {
  static var dba, announcementCollection;

  // static delete(customerSupportModel data) async {
  //   print(data.supId);
  //   await announcementCollection.deleteOne(<String, Object>{'supId': '${data.supId}'});
  // }

  static connectA() async {
    dba = await Db.create(
        "mongodb+srv://natureslinkmobileapp:0woy4h1iUFwOIKOj@cluster0.0u1vd.mongodb.net/?retryWrites=true&w=majority");
    await dba.open();
    inspect(dba);
    announcementCollection = dba.collection("articles");
  }

  static Future<String> insertAnn(announcementModel data) async {
    try {
      var result = await announcementCollection.insertOne(data.toJson());
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
// static Future<String> insertCS(customerSupportModel data) async {
//   try {
//     var result = await announcementCollection.insertOne(data.toJson());
//     if (result.isSuccess) {
//       return "Data Inserted";
//     } else {
//       return "Something Wrong with data";
//     }
//   } catch (e) {
//     print(e.toString());
//     return e.toString();
//   }
// }
}
