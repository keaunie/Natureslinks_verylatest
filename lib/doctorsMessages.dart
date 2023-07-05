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

    var arrData = await chatAppointments.chatAppointCollection.find({
      'duid': globals.objuidString,
    }).toList();

    print(arrData);
    return arrData;
  }

  DateTime selectedDate = DateTime.now();
  DateTime reschedDate = DateTime.now();

  var rescheduleID;
  var rescheduleDate;
  var readyresched = false;

  String afternoontime = '1:00 PM';
  var PMtime = [
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];
  bool update = true;

  var formatsu;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      DateTime now = picked;
      DateTime date = DateTime(now.year, now.month, now.day);
      var formatsu = DateFormat('yyyy-MM-dd');
      setState(() {
        reschedDate = picked;
        rescheduleDate = formatsu.format(date);
        // print(globals.selectedDate);
        selectedDateController.text = "${formatsu.format(date)}";
        // print(selectedDateController.text);
      });
    }
  }

  _showSimpleModalDialog(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAppointmentCard(context),
                  ],
                ),
              ),
            ),
          );
        });
  }

  var selectedDateController = new TextEditingController();

  @override
  Widget buildAppointmentCard(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'ReSchedule Appointment',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                      child: Row(
                    children: [
                      Flexible(
                          child: TextField(
                        decoration: InputDecoration(labelText: "Date"),
                        enabled: false,
                        controller: selectedDateController,
                      )),
                      GestureDetector(
                        onTap: () => {_selectDate(context)},
                        child: Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  )),
                  Visibility(
                    visible: true,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: DropdownButton(
                          alignment: Alignment.centerLeft,
                          iconSize: 30,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                          underline: Container(),
                          iconEnabledColor: Colors.green,
                          // Initial Value
                          value: afternoontime,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: PMtime.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              // timeSelected = afternoontime;
                              afternoontime = newValue!;
                              if (afternoontime == '1:00 PM') {
                                afternoontime = '1PM';
                              } else if (afternoontime == '2:00 PM') {
                                afternoontime = '2PM';
                              } else if (afternoontime == '3:00 PM') {
                                afternoontime = '3PM';
                              } else if (afternoontime == '4:00 PM') {
                                afternoontime = '4PM';
                              } else {
                                afternoontime = '5PM';
                              }
                              print(afternoontime);
                              reSchedule(
                                  rescheduleID, rescheduleDate, afternoontime);
                            });
                            Navigator.pop(context);
                          },
                        ),
                        elevation: 2.5,
                        margin: EdgeInsets.all(10)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> reSchedule(Object id, date, time) async {
    print('im here at reSchedule');
    print(id);
    print(date);
    print(time);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Rescheduled Appointment")));
    var result = await chatAppointments.chatAppointCollection
        .update(M.where.eq('_id', id), M.modify.set('date', date));
    var result2 = await chatAppointments.chatAppointCollection
        .update(M.where.eq('_id', id), M.modify.set('appointmentTime', time));
  }

  Future<void> cancelSchedule(Object id) async {
    print(id);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Cancelled Appointment")));
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
      body: Container(
          decoration:
          const BoxDecoration(image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover)),
        child: SafeArea(
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
      ),
    );
  }

  String? gchat;

  Widget displayCard(appointmentModel data) {
    gchat = "${data.approver}";

    if (data.status == 'COMPLETED') {
      return Card(
          color: Colors.lightGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Text("${data.title}", style: TextStyle(fontSize: 18)),
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
              ])));
    } else if (data.status == 'APPROVED') {
      bool start = true;
      bool cancel = true;

      bool onsite = false;
      bool notif = true;

      DateTime test = DateTime.parse(data.date);
      int test2 = test.day - 1;
      // print(test2);

      DateTime now = DateTime.now();
      DateTime check = now;
      DateTime dd = DateTime(check.year, check.month, check.day);
      var dateformat = DateFormat('yyyy-MM-dd');
      var something = dateformat.format(dd);

      DateTime checktdb = DateTime(check.year, check.month, test2);
      var dateformat2 = DateFormat('yyyy-MM-dd');
      var something2 = dateformat2.format(checktdb);

      if (data.date.toString() == something.toString()) {
        print(data.approver);
        start = true;
        cancel = false;
        notif = false;
        update = false;
        if (data.service != 'CWD') {
          start = false;
        }
      } else {
        notif = false;
        start = false;
        if (something2.toString() == something.toString()) {
          print('test');
          update = false;
          cancel = false;
          String tdbnotif =
              'You cannot cancel or reschedule the day before the appointment';
        }
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text("Your Appointed schedule is : " +
        //         data.date.replaceAll(
        //             RegExp(r'00:00:00.000'), ''))));
      }

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text("${data.title}", style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Text("${data.date}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.appointmentTime}" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
              Visibility(
                  child: Text(
                    'You cannot update or reschedule the day before your appointment!',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  ),
                  visible: notif),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: start,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                friendUid: data.uid,
                                friendName: data.patient,
                                currentUserName: globals.fName)));
                      },
                      child: const Text("Start Appointment"),
                    ),
                  ),
                  // Visibility(
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       backgroundColor:
                  //           MaterialStateProperty.all<Color>(Colors.red),
                  //     ),
                  //     onPressed: () {
                  //       setState(() {});
                  //       cancelSchedule(data.id);
                  //     },
                  //     child: const Text("Cancel Appointment"),
                  //   ),
                  // ),
                ],
              ),
              Visibility(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => reschedDateCard()));
                    rescheduleID = data.id;
                    _showSimpleModalDialog(context);
                    setState(() {});
                  },
                  child: const Text("Reschedule Appointment"),
                ),
              ),
              Visibility(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    _updateStatus(data.id, 'COMPLETED');
                    setState(() {});
                  },
                  child: const Text("Done Appointment"),
                ),
              )
            ],
          ),
        ),
      );
    } else {
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
    var result = await chatAppointments.updateAppointment(id, status);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Accepted appointment!')));
    Navigator.pop(context);
    // print(therefore);
    // print(result);
  }
}
