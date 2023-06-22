library Natureslink.globals;

import 'package:mongo_dart/mongo_dart.dart';

List userInfos = List.empty();

ObjectId? uid;
String? objuidString;
String? email = '';
String? pass = '';
String? fName = '';
String? mName = '';
String? profilepic = '';
String? lName = '';
String? user = '';
String? addr = '';
String? bday = '';
String? gender = '';
String? religion = '';
String? civilStats = '';
String? role = '';

String? titlesu = '';
String? servicesu = '';

String oldpass = '';
String newpass = '';


String chattinguserid = '';

String? chatsu = '';
ObjectId? selectedAppointedDoctorId;
String? objduidString = selectedAppointedDoctorId!.$oid.toString();


String? selectedAppointedDoctorName = '';

String? selectedDoctor = '';
String? selectedTime = '';
DateTime? selectedDate;

String? appointedDoctor;




String? announcetitle;
String? article;
String? authorName;


String? watchVid;
String? titleVid;
String? descVid;

String selectedDateToString = selectedDate.toString();


