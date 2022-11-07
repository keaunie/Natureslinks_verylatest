import 'dart:convert';

import 'package:flutter/material.dart';
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
    final arrData = await chatAppointments.chatAppointCollection
        .find({'uid': globals.uid}).toList();
    return arrData;
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

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      DateTime now = picked;
      DateTime date = DateTime(now.year, now.month, now.day);
      var formatter = DateFormat('MM-dd-yyyy');
      setState(() {
        selectedDate = picked;
        globals.selectedDate = selectedDate;
        print(globals.selectedDate);
        selectedDateController.text = "${formatter.format(date)}";
        print(selectedDateController.text);
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

  Future<void> _insertAppointment(
    M.ObjectId uid,
    String date,
    String doctor,
    String time,
  ) async {
    final data = appointmentModel(
      uid: uid,
      date: date,
      doctor: doctor,
      time: time,
    );

    var result = await chatAppointments.insertCA(data);
  }

  Widget buildSchedule(BuildContext context) {
    return Container(
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
                  onTap: () => {Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()))},
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  'Book a Doctor',
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
          buildAppointmentCard(),
          setTime(),
          setDoctor(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {
              _insertAppointment(globals.uid!, globals.selectedDateToString!,
                  globals.selectedDoctor!, globals.selectedTime!);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: const Text("Appoint"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          buildSchedule(context)));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text('No Schedule Yet!',
                                        style: TextStyle(
                                            fontSize: 30,
                                        ),
                                      ),
                                      Text('Get Your Schedule Here!',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue
                                        ),
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

  Widget displayCard(appointmentModel data) {
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
            Text("${data.time}"),
            SizedBox(
              height: 10,
            ),
            Text("${data.doctor}")
          ],
        ),
      ),
    );
  }
}
