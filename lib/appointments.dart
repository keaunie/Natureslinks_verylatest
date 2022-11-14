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

class appointments extends StatefulWidget {
  const appointments({Key? key}) : super(key: key);

  @override
  State<appointments> createState() => _appointmentsState();
}

class _appointmentsState extends State<appointments> {
  static Future<List<Map<String, dynamic>>> fetchAppointments() async {
    final arrData = await chatAppointments.chatAppointCollection
        .find({'uid': globals.uid}).toList();
    print(arrData);
    return arrData;
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
      M.ObjectId id,
    M.ObjectId duid,
    M.ObjectId uid,
    String patient,
    String date,
    String doctor,
    String time,
    String status,
  ) async {
    final data = appointmentModel(
      id: id,
        duid: duid,
        uid: uid,
        patient: patient,
        date: date,
        doctor: doctor,
        time: time,
        status: status);

    var result = await chatAppointments.insertCA(data);
  }

  String status = 'pending';

  Future <void> checkerAppointment(String doctor, DateTime date, String time) async {


    var getinfo = await chatAppointments.chatAppointCollection.find({'time': time, 'doctor': doctor, 'date': globals.selectedDate.toString()}).toList();
    var anything = getinfo.toString();
    var therefore = anything.replaceAll("[]", "");


    final List<dynamic> dataList = getinfo;
    var dataListToString = dataList.toString();
    var dataListReady = dataListToString.replaceAll("[]", "");

    print(doctor);
    print(globals.selectedDateToString);
    print(time);

    String checkDate = date.toString();

    if(doctor.isEmpty || checkDate.isEmpty || time.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please complete the form")));
    }else{
      if (dataListReady.isEmpty) {
        _insertAppointment(
            M.ObjectId(),
            globals.selectedAppointedDoctorId!,
            globals.uid!,
            globals.fName!,
            globals.selectedDateToString!,
            globals.selectedAppointedDoctorName!,
            globals.selectedTime!,
            status);
        selectedDateController.text = '';
        globals.fName = '';
        globals.selectedDate = null;
        globals.selectedAppointedDoctorName = '';
        globals.selectedTime = '';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Appointed Schedule: " + globals.selectedDateToString + globals.selectedTime!)));
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        print(dataListReady);
        final item = dataList[0];
        if (item['doctor'] == doctor && item['date'] == globals.selectedDate.toString() &&
            item['time'] == globals.selectedTime) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Schedule is Taken, Please choose Another Time")));
        } else {
          print('pasok na pasok boi');
          _insertAppointment(
            M.ObjectId(),
              globals.selectedAppointedDoctorId!,
              globals.uid!,
              globals.fName!,
              globals.selectedDateToString!,
              globals.selectedAppointedDoctorName!,
              globals.selectedTime!,
              status);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Appointed Schedule: " + globals.selectedDateToString + globals.selectedTime!)));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      }
    }
  }

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
                    onTap: () => {Navigator.pop(context)},
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
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setDoctor()));
              },
              child: const Text("List of Doctors"),
            ),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                String checkDate = globals.selectedDate.toString();
                print(checkDate);
                if(checkDate == 'null'){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please choose date")));
                }else{
                  checkerAppointment(globals.selectedAppointedDoctorName!,
                      globals.selectedDate!, globals.selectedTime!);
                  setState(() {});
                }
              },
              child: const Text("Appoint"),
            ),
          ],
        ),
      ),
    );
  }

  Future <void> cancelSchedule(String date, String time) async{
    await chatAppointments.chatAppointCollection.deleteOne({"date": date, "time": time});
  }


  String? gchat;

  Widget displayAppoints(appointmentModel data) {
    gchat = "${data.doctor}";
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            friendUid: "${globals.selectedAppointedDoctorId}",
                            friendName: globals.selectedDoctor,
                            currentUserName: globals.fName)));
                  },
                  child: const Text("Start appointment"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    setState(() {});
                    cancelSchedule(data.date, data.time);
                  },
                  child: const Text("Cancel appointment"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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
