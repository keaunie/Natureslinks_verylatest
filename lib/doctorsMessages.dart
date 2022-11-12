import 'dart:convert';

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

class appointmentsDoctor extends StatefulWidget {
  const appointmentsDoctor({Key? key}) : super(key: key);

  @override
  State<appointmentsDoctor> createState() => _appointmentsDoctorState();
}

class _appointmentsDoctorState extends State<appointmentsDoctor> {
  static Future<List<Map<String, dynamic>>> fetchAppointments() async {
    final arrData = await chatAppointments.chatAppointCollection.find({'duid': globals.uid}).toList();
    print(arrData);
    return arrData;
  }

  Widget buildHeader(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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




  Future<void> _insertAppointment(
      M.ObjectId duid,
      M.ObjectId uid,
      String patient,
      String date,
      String doctor,
      String time,
      String status,) async {
    final data = appointmentModel(
        duid: duid,
        uid: uid,
        patient: patient,
        date: date,
        doctor: doctor,
        time: time,
        status: status
    );

    var result = await chatAppointments.insertCA(data);
  }

  String status = 'pending';

  Widget buildSchedule(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                    onTap: () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()))
                    },
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
            setTime(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                _insertAppointment(globals.selectedAppointedDoctorId!,globals.uid!, globals.fName!, globals.selectedDateToString!,
                    globals.selectedAppointedDoctorName!, globals.selectedTime!, status);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: const Text("Appoint"),
            ),
          ],
        ),
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




  String? gchat;

  Widget displayCard(appointmentModel data) {

    gchat = "${data.doctor}";
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
            Text("${data.doctor}"),
            SizedBox(
              height: 10,
            ),
            Text("${data.status}"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(friendUid: "${data.uid}",
                            friendName: "${data.patient}",
                            currentUserName: "${data.doctor}")));
              },
              child: const Text("Start"),
            ),
          ],
        ),
      ),
    );
  }}
