import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:natureslink/appointments.dart';
import 'package:natureslink/chatApp/chatpage.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/profile.dart';
import 'package:natureslink/setDoctor.dart';
import 'package:natureslink/setTime.dart';
import 'package:natureslink/videoList.dart';
import 'package:natureslink/vtutorial.dart';
import 'package:natureslink/profile.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:natureslink/globals.dart' as globals;
import 'videosTutorial.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Home> {
  Widget buildCard(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.5),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      ' Book an\n Appointment \n Online',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      appointments()));
                        },
                        child: const Text("Get Started")),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Widget buildAppointedSchedule() => Card(
        color: Colors.greenAccent.withOpacity(0.6),
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
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                appointments()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    child: Column(
                                      children: [
                                        Card(
                                          color:
                                              Color.fromRGBO(46, 136, 87, 0.6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Schedules",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                  ],
                ),
              )
            ],
          ),
        ),
      );

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

  // String? timeSelected = '';
  //
  // bool AM = true;
  // bool PM = false;
  //
  // bool _visible = true;
  //
  // void _toggle() {
  //   setState(() {
  //     _visible = !_visible;
  //   });
  // }
  //
  // Widget buildTime() => Card(
  //       color: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: Container(
  //         width: double.infinity,
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               child: Column(
  //                 children: <Widget>[
  //                   Text(
  //                     'Time Available',
  //                     textAlign: TextAlign.left,
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 25,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   ToggleSwitch(
  //                     minWidth: 50.0,
  //                     initialLabelIndex: 0,
  //                     cornerRadius: 10.0,
  //                     activeFgColor: Colors.white,
  //                     inactiveBgColor: Colors.grey,
  //                     inactiveFgColor: Colors.white,
  //                     totalSwitches: 2,
  //                     labels: ['AM', 'PM'],
  //                     activeBgColors: [
  //                       [Colors.greenAccent],
  //                       [Colors.greenAccent],
  //                     ],
  //                     onToggle: (index) {
  //                       if (index == 1) {
  //                         setState(() {
  //                           AM = false;
  //                           PM = true;
  //                         });
  //                       } else {
  //                         setState(() {
  //                           AM = true;
  //                           PM = false;
  //                         });
  //                       }
  //                     },
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Visibility(
  //                     visible: AM,
  //                     child: ToggleSwitch(
  //                       minWidth: 90.0,
  //                       initialLabelIndex: 0,
  //                       cornerRadius: 30.0,
  //                       activeFgColor: Colors.white,
  //                       inactiveBgColor: Colors.grey,
  //                       inactiveFgColor: Colors.white,
  //                       totalSwitches: 3,
  //                       labels: ['9:30 AM', '10:30 AM', '11:30 AM'],
  //                       activeBgColors: [
  //                         [Colors.greenAccent],
  //                         [Colors.greenAccent],
  //                         [Colors.greenAccent]
  //                       ],
  //                       onToggle: (index) {
  //                         if (index == 2) {
  //                           timeSelected = "11:30 AM";
  //                         } else if (index == 1) {
  //                           timeSelected = "10:30 AM";
  //                         } else {
  //                           timeSelected = "9:30 AM";
  //                         }
  //                         print('switched to: $timeSelected');
  //                       },
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );

  // var items = [
  //   'Doc John Francis Bernardo - Cert Acupunturist/ Naturopathic Practioner and Clinician',
  //   'Mellanie Bernardo - Wellness Admin Shaw Center',
  //   'Jenelyn Rodriguez - Wellness Officer in Charge Bacoor, Cavite',
  //   'Mark Kevin Fulminar- Wellness Assistant (Care/Patient Therapy)',
  //   'Angelo Pilar - Wellness Assistant (Patient Care)',
  //   'Karen Calces- Wellness Assistant (Patient Care)',
  //   'Donna Bautista - Wellness OIC Dasma',
  //   'Maloureen Inocencio - Wellness Asst (Product Promo/Marketing)',
  //   'Shiela Cedeno- Wellness Assistant (Pain Mgt Therapy)',
  //   'Raymond Pones-  Wellness Assistant (Patient Care)',
  //   'Raymond Pones-  Wellness Assistant (Patient Care)',
  // ];
  //
  // String dropdownvalue =
  //     'Doc John Francis Bernardo - Cert Acupunturist/ Naturopathic Practioner and Clinician';
  //
  // var doctorController = new TextEditingController();

  // Widget buildAvailDoctors() => Card(
  //       color: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: Container(
  //         width: double.infinity,
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               child: Column(
  //                 children: <Widget>[
  //                   Text(
  //                     'Doctors Available',
  //                     textAlign: TextAlign.left,
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 25,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   Container(
  //                       child: SingleChildScrollView(
  //                           scrollDirection: Axis.horizontal,
  //                           physics: AlwaysScrollableScrollPhysics(),
  //                           padding: EdgeInsets.symmetric(
  //                             vertical: 10,
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               DropdownButton(
  //                                 alignment: Alignment.centerLeft,
  //                                 iconSize: 30,
  //                                 style: TextStyle(
  //                                   fontSize: 16,
  //                                   color: Colors.black54,
  //                                 ),
  //                                 // Initial Value
  //                                 value: dropdownvalue,
  //
  //                                 // Down Arrow Icon
  //                                 icon: const Icon(Icons.keyboard_arrow_down),
  //
  //                                 // Array list of items
  //                                 items: items.map((String items) {
  //                                   return DropdownMenuItem(
  //                                     value: items,
  //                                     child: Text(items),
  //                                   );
  //                                 }).toList(),
  //                                 // After selecting the desired option,it will
  //                                 // change button value to selected value
  //                                 onChanged: (String? newValue) {
  //                                   setState(() {
  //                                     dropdownvalue = newValue!;
  //                                     doctorController.text = dropdownvalue;
  //                                   });
  //                                 },
  //                               ),
  //                             ],
  //                           ))),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //
  // Future<void> checkerAppointment(
  //     String doctor, DateTime date, String time) async {
  //   var getinfo = await chatAppointments.chatAppointCollection.find({
  //     'time': time,
  //     'doctor': doctor,
  //     'date': globals.selectedDate.toString()
  //   }).toList();
  //   var anything = getinfo.toString();
  //
  //   final List<dynamic> dataList = getinfo;
  //   var dataListToString = dataList.toString();
  //   var dataListReady = dataListToString.replaceAll("[]", "");
  //
  //   print(doctor);
  //   print(globals.selectedDateToString);
  //   print(time);
  //
  //   String checkDate = date.toString();
  //
  //   if (doctor.isEmpty || checkDate.isEmpty || time.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Please complete the form")));
  //   } else {
  //     if (dataListReady.isEmpty) {
  //       _insertAppointment(
  //           M.ObjectId(),
  //           globals.selectedAppointedDoctorId!,
  //           globals.uid!,
  //           globals.fName!,
  //           globals.selectedDateToString!,
  //           globals.selectedAppointedDoctorName!,
  //           globals.selectedTime!,
  //           status);
  //
  //       // selectedDateController.text = '';
  //       // globals.fName = '';
  //       // globals.selectedDate = null;
  //       // globals.selectedAppointedDoctorName = '';
  //       // globals.selectedTime = '';
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("Appointed Schedule: " +
  //               globals.selectedDateToString.replaceAll(RegExp(r'00:00:00.000'), '') +
  //               globals.selectedTime!)));
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Home()));
  //     } else {
  //       print(dataListReady);
  //       final item = dataList[0];
  //       if (item['doctor'] == doctor &&
  //           item['date'] == globals.selectedDate.toString() &&
  //           item['time'] == globals.selectedTime) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content: Text("Schedule is Taken, Please choose Another Time")));
  //       } else {
  //         setState(() {
  //           _insertAppointment(
  //               M.ObjectId(),
  //               globals.selectedAppointedDoctorId!,
  //               globals.uid!,
  //               globals.fName!,
  //               selectedDate.toString(),
  //               globals.selectedAppointedDoctorName!,
  //               globals.selectedTime!,
  //               status);
  //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               content: Text("Appointed Schedule: " +
  //                   globals.selectedDateToString.replaceAll(RegExp(r'00:00:00.000'), '') +
  //                   globals.selectedTime!)));
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Home()));
  //         });
  //       }
  //     }
  //   }
  // }

  String status = 'pending';

  Future<void> fetchVid() async {
    final arrData = await videoTutorial.videoTutCollection.find().toList();
    print(arrData);
  }

  // Widget buildSchedule(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
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
  //                   onTap: () => {Navigator.pop(context)},
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
  //           buildAppointmentCard(),
  //           setTime(),
  //           ElevatedButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  //             ),
  //             onPressed: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => setDoctor()));
  //             },
  //             child: const Text("List of Doctors"),
  //           ),
  //           ElevatedButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  //             ),
  //             onPressed: () {
  //               String checkDate = globals.selectedDate.toString();
  //               print(checkDate);
  //               if (checkDate == 'null') {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(content: Text("Please choose date")));
  //               } else {
  //                 setState(() {
  //                   checkerAppointment(globals.selectedAppointedDoctorName!,
  //                       globals.selectedDate!, globals.selectedTime!);
  //                 });
  //               }
  //             },
  //             child: const Text("Appoint"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  //
  // Widget buildSchedule(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
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
  //                   onTap: () => {Navigator.pop(context)},
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
  //           buildAppointmentCard(),
  //           setTime(),
  //           ElevatedButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  //             ),
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => setDoctor()));
  //             },
  //             child: const Text("List of Doctors"),
  //           ),
  //
  //           ElevatedButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  //             ),
  //             onPressed: () {
  //               String checkDate = globals.selectedDate.toString();
  //               print(checkDate);
  //               setState(() {});
  //               if(checkDate == 'null'){
  //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                     content: Text("Please choose date")));
  //               }else{
  //
  //                 checkerAppointment(globals.selectedAppointedDoctorName!, globals.selectedDate!, globals.selectedTime!);
  //               }
  //             },
  //             child: const Text("Appoint"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Future<void> _insertAppointment(
  //   M.ObjectId id,
  //   M.ObjectId duid,
  //   M.ObjectId uid,
  //   String patient,
  //   String date,
  //   String doctor,
  //   String time,
  //   String status,
  // ) async {
  //   final data = appointmentModel(
  //       id: id,
  //       duid: duid,
  //       uid: uid,
  //       patient: patient,
  //       date: date,
  //       doctor: doctor,
  //       time: time,
  //       status: status);
  //
  //   var result = await chatAppointments.insertCA(data);
  // }

  Widget announcements() {
    if (globals.article == null || globals.announcetitle == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No announcement Yet',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            globals.announcetitle!,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              globals.article!,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      );
    }
  }

  Widget buildAnnounce() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.5),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 25,
      ),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Announcement',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              announcements(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRoundedCard1() => Card(
        color: Color.fromRGBO(46, 136, 87, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Homeopathy",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildRoundedCard2() => Card(
        color: Color.fromRGBO(46, 136, 87, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pain \n Management Theraphy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildRoundedCard3() => Card(
        color: Color.fromRGBO(46, 136, 87, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Acupuncture',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildRoundedCard4() => Card(
        color: Color.fromRGBO(46, 136, 87, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'And \n Many More...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildTherapies() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.5),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 25,
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Other Services Offered',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Row(
                children: <Widget>[
                  buildRoundedCard1(),
                  SizedBox(width: 10),
                  buildRoundedCard2(),
                  SizedBox(width: 10),
                  buildRoundedCard3(),
                  SizedBox(width: 10),
                  buildRoundedCard4(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDoctor1(BuildContext context) => Card(
        color: Color.fromRGBO(46, 136, 87, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => Chat()));
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Doc Bunny',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ACG, 717B Shaw Blvd, \n Mandaluyong, 1555 Metro Manila',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildDoctor2() => Card(
        color: Color.fromRGBO(46, 136, 87, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Jenelyn Rodriguez \n '
                  'Wellness Officer in Charge',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Bacoor Cavite',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildDoctors(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.greenAccent.withOpacity(0.5)),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Doctors',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildDoctor1(context),
                  SizedBox(height: 15),
                  buildDoctor2(),
                  SizedBox(height: 15),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildTutorials(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.5),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => videoList()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            'Video Tutorials',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          // SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children: [
          //         buildTutorial1(context),
          //         SizedBox(height: 15),
          //       ],
          //     )),
        ],
      ),
    );
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



  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });


    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration:
            const BoxDecoration(image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildHeader(context),
              SizedBox(height: 20),
              buildCard(context),
              SizedBox(height: 20),
              buildAnnounce(),
              SizedBox(height: 15),
              buildAppointedSchedule(),
              SizedBox(height: 15),
              buildTherapies(),
              SizedBox(height: 15),
              // buildDoctors(context),
              // SizedBox(height: 15),
              buildTutorials(context),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
