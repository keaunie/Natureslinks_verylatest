// import 'package:flutter/material.dart';
// import 'package:natureslink/dbHelper/MongoDbModel.dart';
// import 'package:natureslink/dbHelper/mongodb.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class MongoDbDisplay extends StatefulWidget {
//   const MongoDbDisplay({Key? key}) : super(key: key);
//
//   @override
//   State<MongoDbDisplay> createState() => _MongoDbDisplayState();
// }
//
// class _MongoDbDisplayState extends State<MongoDbDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: FutureBuilder(
//               future: MongoDatabase.getData(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   if (snapshot.hasData) {
//                     var totalData = snapshot.data.length;
//                     print("Total Data: " + totalData.toString());
//                     return ListView.builder(
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (context, index) {
//                           return displayCard(
//                               MongoDbModel.fromJson(snapshot.data[index]));
//                         });
//                   } else {
//                     return Center(
//                       child: Text("No Data Available"),
//                     );
//                   }
//                 }
//               })),
//     );
//   }
//
//   Widget displayCard(MongoDbModel data) {
//     Future<void> getInfos() async {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString('userName', "${data.userName}");
//       prefs.setString('firstName', "${data.firstName}");
//     }
//
//
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text("${data.userName}"),
//             Text("${data.email}"),
//             Text("${data.firstName}"),
//             Text("${data.middleName}"),
//             Text("${data.lastName}"),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// String userValue = '';
// Future<void> getInfos() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
// }
