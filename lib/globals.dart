library Natureslink.globals;

import 'package:mongo_dart/mongo_dart.dart';

List userInfos = List.empty();

ObjectId? uid;
String? email = '';
String? pass = '';
String? fName = '';
String? mName = '';
String? lName = '';
String? user = '';
String? addr = '';
String? bday = '';
String? gender = '';
String? religion = '';
String? civilStats = '';
String? role = '';

String? chatsu = '';
ObjectId? selectedAppointedDoctorId;
String? selectedAppointedDoctorName = '';

String? selectedDoctor = '';
String? selectedTime = '';
DateTime? selectedDate;

String selectedDateToString = selectedDate.toString();


