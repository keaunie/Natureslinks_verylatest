import 'package:flutter/material.dart';
import 'package:natureslink/appointments.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/globals.dart' as globals;

class setDoctor extends StatefulWidget {
  const setDoctor({Key? key}) : super(key: key);

  @override
  State<setDoctor> createState() => _setDoctorState();
}

class _setDoctorState extends State<setDoctor> {
  // String role = 'admin';

  static Future<List<Map<String, dynamic>>> fetchDoctors() async {
    final arrData = await MongoDatabase.userCollection.find({'role': 'doctor'}).toList();
    print(arrData);
    return arrData;
  }

  // var items = [
  //   'Select Doctor',
  //   'Doc Eleuterio Bernardo (Doc Bunny)',
  //   'Doc John Francis Bernardo - Cert Acupunturist/ Naturopathic Practioner and Clinician',
  //   'Mellanie Bernardo - Wellness Admin Shaw Center',
  //   'Jenelyn Rodriguez - Wellness Officer in Charge Bacoor, Cavite',
  //   'Mark Kevin Fulminar- Wellness Assistant (Care/Patient Therapy)',
  //   'Angelo Pilar - Wellness Assistant (Patient Care)',
  //   'Karen Calces- Wellness Assistant (Patient Care)',
  //   'Donna Bautista - Wellness OIC Dasma',
  //   'Maloureen Inocencio - Wellness Asst. (Product Promo/Marketing)',
  //   'Shiela Cedeno- Wellness Assistant (Pain Mgt Therapy)',
  //   'Raymond Pones-  Wellness Assistant (Patient Care)',
  // ];

  // String dropdownvalue = 'Select Doctor';

  var doctorController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: fetchDoctors(),
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
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         buildSchedule(context)));
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
                            return displayCard(
                                MongoDbModel.fromJson(snapshot.data[index]));
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

  Widget displayCard(MongoDbModel data) {
    gchat = "${data.firstName}";
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text("${data.firstName}"),
            SizedBox(
              height: 10,
            ),
            Text("${data.middleName}"),
            SizedBox(
              height: 10,
            ),
            Text("${data.lastName}"),
            SizedBox(
              height: 10,
            ),
            Text("${data.email}"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                setState(() {
                  globals.objduidString = data.id?.$oid.toString();
                  globals.selectedDoctor = data.firstName + " " + data.lastName;
                  globals.selectedAppointedDoctorId = data.id;
                  globals.selectedAppointedDoctorName = data.firstName +
                      " " +
                      data.middleName +
                      " " +
                      data.lastName;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Selected: " + globals.selectedDoctor!)));
                  print(globals.selectedAppointedDoctorId);
                });
                Navigator.pop(context);
              },
              child: const Text("Appoint"),
            ),
          ],
        ),
      ),
    );
  }
}
