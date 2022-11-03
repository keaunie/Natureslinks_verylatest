import 'package:flutter/material.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'globals.dart' as globals;

class appointments extends StatefulWidget {
  const appointments({Key? key}) : super(key: key);

  @override
  State<appointments> createState() => _appointmentsState();
}

class _appointmentsState extends State<appointments> {

  List<appointmentModel> _appoint = <appointmentModel>[];

  Future<List<appointmentModel>> fetchAppointments(String uid) async {


    var allUserAppointments = await chatAppointments.chatAppointCollection.find({'uid': globals.uid});

    var appoints = <appointmentModel>[];

    for (var appointJson in allUserAppointments){
      appoints.add(appointmentModel.fromJson(allUserAppointments));
    }

    print(allUserAppointments);

    return appoints;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index){
        return Card(
          color: Color.fromRGBO(46, 139, 87, 0.6),
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
                        'Appointments With Doctors',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Card(
                                      color: Color.fromRGBO(46, 139, 87, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Text(
                                              _appoint[index].date,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              _appoint[index].time,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              _appoint[index].doctor,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
