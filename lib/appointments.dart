import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
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

class appointments extends StatefulWidget {
  const appointments({Key? key}) : super(key: key);

  @override
  State<appointments> createState() => _appointmentsState();
}

class _appointmentsState extends State<appointments> {
  static Future<List<Map<String, dynamic>>> fetchAppointments() async {
    print(globals.objuidString);
    var arrData = await chatAppointments.chatAppointCollection.find({
      'uid': globals.objuidString,
      'status': 'APPROVED',
    }).toList();

    if (arrData.toString().replaceAll('[]', '') == '') {
      // print('test');
      var arrData2 = await chatAppointments.chatAppointCollection.find({
        'uid': globals.objuidString,
        'status': 'PENDING',
      }).toList();

      arrData = arrData2;
    }

    print(arrData);
    return arrData;
  }

  DateTime selectedDate = DateTime.now();

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
      var formatsu = DateFormat('MM-dd-yyyy');
      setState(() {
        selectedDate = picked;
        globals.selectedDate = selectedDate;
        // print(globals.selectedDate);
        selectedDateController.text = "${formatsu.format(date)}";
        // print(selectedDateController.text);
      });
    }
  }

  var selectedDateController = new TextEditingController();

  Widget buildAppointmentCard() => Card(
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
                      'Schedule Appointment',
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
                  ],
                ),
              )
            ],
          ),
        ),
      );

  // Future<void> _insertAppointment(
  //   M.ObjectId id,
  //   String duid,
  //   String uid,
  //   String title,
  //   String email,
  //   String service,
  //   String patient,
  //   DateTime date,
  //   String appointmentTime,
  // ) async {
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   var selectedDatesu = formatter.format(date);
  //   final data = appointmentModel(
  //       id: id,
  //       duid: duid,
  //       uid: uid,
  //       title: title,
  //       email: globals.email!,
  //       service: globals.servicesu!,
  //       approver: globals.selectedAppointedDoctorName!,
  //       patient: patient,
  //       date: selectedDatesu.toString(),
  //       appointmentTime: appointmentTime,
  //       backgroundColor: 'orange',
  //       status: 'PENDING',
  //       postDate: DateTime.now());
  //
  //   globals.servicesu = '';
  //   globals.objduidString = '';
  //   globals.selectedAppointedDoctorId = null;
  //   var result = await chatAppointments.insertCA(data);
  // }

  Widget buildSchedule(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {
                      selectedDateController = new TextEditingController(),
                      globals.objduidString = '',
                      globals.selectedAppointedDoctorName = '',
                      globals.selectedDoctor = '',
                      globals.selectedTime = '',
                      Navigator.pop(context)
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Book Appointment',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // buildAppointmentCard(),
            setTime(),
          ],
        ),
      ),
    );
  }

  Future<void> cancelSchedule(Object id) async {
    print(id);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Cancelled Appointment")));
    var result = await chatAppointments.chatAppointCollection
        .update(M.where.eq('_id', id), M.modify.set('status', 'CANCELLED'));
  }

  String? gchat;

  Widget displayAppoints(appointmentModel data) {
    gchat = "${data.approver}";

    String approverstate = '';
    bool approved1 = false;
    if (data.approver == '') {
      approverstate = 'waiting for approval';
    } else {
      approverstate = data.approver;
    }

    String booked = '';
    if (data.service == 'CWD') {
      booked = 'Online Appointment';
    } else {
      booked = 'Physical Appointment';
      approved1 = false;
    }

    print(data.duid);
    if (data.status == 'PENDING') {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Image.network('', height: 100),
              SizedBox(
                height: 10,
              ),
              Text("${data.date.replaceAll(RegExp(r'00:00:00.000'), '')}"),
              SizedBox(
                height: 10,
              ),
              Text("${data.appointmentTime}"),
              SizedBox(
                height: 10,
              ),
              Text("$approverstate"),
              SizedBox(
                height: 10,
              ),
              Text("${data.status}"),
              SizedBox(
                height: 10,
              ),
              Text("$booked"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      setState(() {});
                      cancelSchedule(data.id);
                    },
                    child: const Text("Cancel appointment"),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else if (data.status == 'APPROVED') {
      bool start = false;
      bool cancel = false;
      bool onsite = false;

      DateTime now = DateTime.now();
      DateTime check = now;
      DateTime dd =
      DateTime(check.year, check.month, check.day);
      var dateformat = DateFormat('yyyy-MM-dd');
      var something = dateformat.format(dd);
      print(something);
      print(data.date);
      if (data.date.toString() == something.toString()) {
        print(data.approver);
        start = true;
        cancel = false;
        if(data.service != 'CWD'){
          start = false;
        }
      } else {
        start = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Your Appointed schedule is : " +
                data.date.replaceAll(
                    RegExp(r'00:00:00.000'), ''))));
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
              Text("${data.appointmentTime}"),
              SizedBox(
                height: 10,
              ),
              Text("$approverstate"),
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
                                friendUid: data.duid,
                                friendName: data.approver,
                                currentUserName: globals.fName)));
                      },
                      child: const Text("Start Appointment"),
                    ),
                  ),

                  Visibility(
                    visible: cancel,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        setState(() {});
                        cancelSchedule(data.id);
                      },
                      child: const Text("Cancel Appointment"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 400,
          ),
          Center(
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => buildSchedule(context)));
                },
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'No Schedule Yet!',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        'Get Your Schedule Here!',
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      );
    }
  }

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
                    // print("Total Data: " + totalData.toString());
                    if (totalData == 0) {
                      return Center(
                        child: Column(
                          children: [
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          buildSchedule(context)));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'No Schedule Yet!',
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ),
                                      Text(
                                        'Get Your Schedule Here!',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.blue),
                                      ),
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
                            return displayAppoints(appointmentModel
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
}
