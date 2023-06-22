import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:natureslink/appointments.dart';
import 'package:natureslink/chatApp/chatpage.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:natureslink/home.dart';
import 'package:natureslink/profile.dart';
import 'package:natureslink/setDoctor.dart';
import 'package:natureslink/setTime.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as globals;

class appointmentsDoctor extends StatefulWidget {
  const appointmentsDoctor({Key? key}) : super(key: key);

  @override
  State<appointmentsDoctor> createState() => _appointmentsDoctorState();
}

class _appointmentsDoctorState extends State<appointmentsDoctor> {
  static Future<List<Map<String, dynamic>>> fetchAppointments() async {
    print(globals.objuidString);
    // var arrData = await chatAppointments.chatAppointCollection
    //     .find({'duid': globals.objuidString, 'status': 'APPROVED',}).toList();
    //
    // if(arrData.toString().replaceAll('[]', '') == ''){
    //   print('test');
    //   var arrData2 = await chatAppointments.chatAppointCollection
    //       .find({'duid': globals.objuidString, 'status': 'PENDING',}).toList();
    //
    //   arrData = arrData2;
    // }

    var arrData = await chatAppointments.chatAppointCollection
        .find({'duid': globals.objuidString,}).toList();




    print(arrData);
    return arrData;
  }

  Future<void> cancelSchedule(Object id) async {
    print(id);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cancelled Appointment")));
    var result = await chatAppointments.chatAppointCollection
        .update(M.where.eq('_id', id), M.modify.set('status', 'CANCELLED'));
  }

  Widget buildHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Text(
                  'Natureslink',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("""
assets/images/logo.png"""), fit: BoxFit.cover),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _insertAppointment(
  //   M.ObjectId id,
  //   M.ObjectId duid,
  //   M.ObjectId uid,
  //   String patient,
  //   String date,
  //   String approver,
  //   String appointmentTime,
  //   String status,
  // ) async {
  //   final data = appointmentModel(
  //       id: id,
  //       duid: duid,
  //       uid: uid,
  //       patient: patient,
  //       date: date,
  //       approver: approver,
  //       appointmentTime: appointmentTime,
  //       status: status);
  //
  //   var result = await chatAppointments.insertCA(data);
  // }

  String status = 'pending';

  // Widget buildSchedule(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Container(
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Colors.greenAccent,
  //       ),
  //       child: Column(
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               color: Color.fromRGBO(255, 255, 255, 1),
  //             ),
  //             alignment: Alignment.centerLeft,
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 25,
  //               vertical: 20,
  //             ),
  //             child: Row(
  //               children: [
  //                 GestureDetector(
  //                   onTap: () => {
  //                     Navigator.push(context,
  //                         MaterialPageRoute(builder: (context) => Home()))
  //                   },
  //                   child: Icon(
  //                     Icons.arrow_back_ios_new_rounded,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 Spacer(),
  //                 Text(
  //                   'Book a Doctor',
  //                   style: TextStyle(
  //                       decoration: TextDecoration.none,
  //                       color: Colors.black,
  //                       fontSize: 30,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //                 Spacer(),
  //               ],
  //             ),
  //           ),
  //           setTime(),
  //           ElevatedButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  //             ),
  //             onPressed: () {
  //               _insertAppointment(
  //                 M.ObjectId(),
  //                   globals.selectedAppointedDoctorId!,
  //                   globals.uid!,
  //                   globals.fName!,
  //                   globals.selectedDateToString!,
  //                   globals.selectedAppointedDoctorName!,
  //                   globals.selectedTime!,
  //                   status);
  //               Navigator.push(
  //                   context, MaterialPageRoute(builder: (context) => Home()));
  //             },
  //             child: const Text("Appoint"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: fetchAppointments(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totalData = snapshot.data.length;
                    print("Total Data: " + totalData.toString());
                    if (totalData == 0) {
                      return Center(
                        child: Column(
                          children: [
                            Spacer(),
                            InkWell(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Congrats!',
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ),
                                      Text(
                                        'No Schedule Yet!',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      // Text(
                                      //   'Get Your Schedule Here!',
                                      //   style: TextStyle(
                                      //       fontSize: 15, color: Colors.blue),
                                      // ),
                                    ],
                                  ),
                                )),
                            Spacer(),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(appointmentModel
                                .fromJson(snapshot.data[index]));
                          });
                    }
                  } else {
                    return Center(
                      child: Text("No Scheduled yet!"),
                    );
                  }
                }
              }),
        ),
      ),
    );
  }

  String? gchat;

  Widget displayCard(appointmentModel data) {
    gchat = "${data.approver}";

    if(data.status == 'PENDING'){
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text("${data.date}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.appointmentTime}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.approver}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.status}"),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {

                      _updateStatus(data.id, 'APPROVED');
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ChatScreen(
                      //         friendUid: "${data.uid}",
                      //         friendName: "${data.patient}",
                      //         currentUserName: "${data.doctor}")));
                    },
                    child: const Text("Accept Appointment"),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      setState(() {});
                      cancelSchedule(data.id);
                    },
                    child: const Text("Cancel Appointment"),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }else if(data.status == 'APPROVED'){
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text("${data.date}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.appointmentTime}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.patient}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.status}"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      DateTime now = DateTime.now();
                      DateTime check = now;
                      DateTime dd = DateTime(check.year, check.month, check.day);
                      var dateformat = DateFormat('yyyy-MM-dd');
                      var something = dateformat.format(dd);
                      print(something);
                      print(data.date);
                      if (data.date.toString() == something.toString()) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                friendUid: data.uid,
                                friendName: data.patient,
                                currentUserName: globals.fName)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Your Appointed schedule is : " +
                                data.date
                                    .replaceAll(RegExp(r'00:00:00.000'), ''))));
                      }
                    },
                    child: const Text("Start Appointment"),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      setState(() {});
                      cancelSchedule(data.id);
                    },
                    child: const Text("Cancel Appointment"),
                  ),
                ],
              )

            ],
          ),
        ),
      );
    }else{
      return Card();
    }
    // return Card(
    //   child: Padding(
    //     padding: const EdgeInsets.all(5.0),
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text("${data.date}"),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text("${data.time}"),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text("${data.doctor}"),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text("${data.status}"),
    //         SizedBox(
    //           height: 10,
    //         ),
    //
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             ElevatedButton(
    //               style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).push(MaterialPageRoute(
    //                     builder: (context) => ChatScreen(
    //                         friendUid: "${data.uid}",
    //                         friendName: "${data.patient}",
    //                         currentUserName: "${data.doctor}")));
    //               },
    //               child: const Text("Start Appointment"),
    //             ),
    //             ElevatedButton(
    //               style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
    //               ),
    //               onPressed: () {
    //                 setState(() {});
    //                 cancelSchedule(data.date, data.time);
    //               },
    //               child: const Text("Cancel Appointment"),
    //             ),
    //           ],
    //         )
    //
    //       ],
    //     ),
    //   ),
    // );
  }

  Future<void> _updateStatus(
      Object id,
      String status,
      ) async {
    var result = await chatAppointments.updateAppointment(id, 'APPROVED');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Accepted appointment!')));
    Navigator.pop(context);
    // print(therefore);
    // print(result);
  }
}
