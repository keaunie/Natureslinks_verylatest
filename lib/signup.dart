import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/home.dart';
import 'package:natureslink/login.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  Widget buildRoundedCard1() => Card(
        color: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );

  String dropdownvalue = 'Civil Status';
  var emailController = new TextEditingController();
  var userController = new TextEditingController();
  var passController = new TextEditingController();
  var fnameController = new TextEditingController();
  var mnameController = new TextEditingController();
  var lnameController = new TextEditingController();
  var addrController = new TextEditingController();
  var contactNoController = new TextEditingController();
  var bdayController = new TextEditingController();
  var genderController = new TextEditingController();
  var religionController = new TextEditingController();
  var csController = new TextEditingController();

  // List of items in our dropdown menu
  var items = [
    'Civil Status',
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  String gender = "";

  Widget buildProfileInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
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
                  'Profile',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: emailController,
                  decoration: (InputDecoration(labelText: "Email: ")),
                ),
                TextField(
                  obscureText: true,
                  controller: passController,
                  decoration: (InputDecoration(labelText: "Password: ")),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: fnameController,
                  decoration: (InputDecoration(labelText: "First Name: ")),
                ),
                TextField(
                  controller: mnameController,
                  decoration: (InputDecoration(labelText: "Middle Name: ")),
                ),
                TextField(
                  controller: lnameController,
                  decoration: (InputDecoration(labelText: "Last Name: ")),
                ),
                TextField(
                  controller: userController,
                  decoration: (InputDecoration(labelText: "Nickname: ")),
                ),
                TextField(
                  controller: contactNoController,
                  decoration: (InputDecoration(labelText: "Contact no.: ")),
                ),
                TextField(
                  controller: addrController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: (InputDecoration(labelText: "Address: ")),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 20,
                ),
                buildBirthdayCard(),
                SizedBox(
                  height: 20,
                ),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: ['Male', 'Female'],
                  icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                  activeBgColors: [
                    [Colors.blue],
                    [Colors.pink]
                  ],
                  onToggle: (index) {
                    if (index == 1) {
                      gender = "Female";
                    } else {
                      gender = "Male";
                    }
                    genderController.text = gender;
                    print('switched to: $gender');
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 200.0,
                        child: TextField(
                            controller: religionController,
                            decoration:
                                InputDecoration(labelText: "Religion: "))),
                    DropdownButton(
                      alignment: Alignment.centerLeft,
                      iconSize: 30,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          csController.text = dropdownvalue;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      DateTime now = picked;
      DateTime date = DateTime(now.year, now.month, now.day);
      var formatter = DateFormat('MM-dd-yyyy');
      setState(() {
        selectedDate = picked;
        bdayController.text = "${formatter.format(date)}";
      });
    }
  }

  Widget buildBirthdayCard() => Card(
        color: Colors.white60,
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
                      'Birthday',
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
                          decoration: InputDecoration(labelText: "Birthday"),
                          enabled: false,
                          controller: bdayController,
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
                GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                Spacer(),
                Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }


  // Future addUser() async {
  //   try {
  //     return await Dio().post('https://capsnucare.herokuapp.com/register-user',
  //         data: {
  //           "role": 'admin',
  //           "email": 'keaunieting@gmail.com',
  //           "password": 'keaunieting05',
  //           "firstname": 'Keaunie',
  //           "middlename": 'Bravo',
  //           "lastname": 'Ting',
  //           "birthdate": '08-05-2000',
  //           "gender": 'Male',
  //           "status": 'Single',
  //           "nationality": 'Filipino',
  //           "religion": 'Roman Catholic',
  //           "contact": '09774939050',
  //         },
  //         options: Options(contentType: Headers.formUrlEncodedContentType));
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  // }

  // MongoDbModel mongo = MongoDbModel(userName: '', email: '', password: '', firstName: '', middleName: '', lastName: '', address: '', birthday: '', gender: '', religion: '', civilStatus: '');
  // Future userSave() async{
  //   try{
  //     Map data = {
  //       "email": mongo.email,
  //       "user": mongo.userName,
  //       "pass": mongo.password,
  //       "fname": mongo.firstName,
  //       "mname": mongo.middleName,
  //       "lname": mongo.lastName,
  //       "addr": mongo.address,
  //       "bday": mongo.birthday,
  //       "gender": mongo.gender,
  //       "religion": mongo.religion,
  //       "status": mongo.civilStatus,
  //     };
  //     String body = json.encode(data);
  //     http.Response response = await http.post(
  //         Uri.parse('https://capsnucare.herokuapp.com/adduser'),
  //         headers: {'Content-Type': 'application/json; charset=utf-8'},
  //       body: body,
  //     );
  //     print(response.body);
  //     if(response.statusCode == 201){
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("You are now registered: " + fnameController.text)));
  //     }else{
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("You need to review Something")));
  //     }
  //   }catch (e){
  //     print(e);
  //   }
  // }

  Widget buildRegister(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () {
          _insertData(
              emailController.text,
              userController.text,
              passController.text,
              fnameController.text,
              mnameController.text,
              lnameController.text,
              addrController.text,
              contactNoController.text,
              bdayController.text,
              genderController.text,
              religionController.text,
              csController.text,
              "patient");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(
      String email,
      String user,
      String pass,
      String fname,
      String mname,
      String lname,
      String addr,
      String contactNo,
      String bday,
      String gender,
      String religion,
      String cs,
      String role) async {
    final data = MongoDbModel(
      email: email,
      userName: user,
      password: pass,
      firstName: fname,
      middleName: mname,
      lastName: lname,
      address: addr,
      contactNo: contactNo,
      birthday: bday,
      gender: gender,
      religion: religion,
      civilStatus: cs,
      role: role,
    );
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You are now registered: " + fname)));
    _clearAll();
  }

  void _clearAll() {
    emailController.text = "";
    userController.text = "";
    passController.text = "";
    fnameController.text = "";
    mnameController.text = "";
    lnameController.text = "";
    addrController.text = "";
    bdayController.text = "";
    genderController.text = "0";
    religionController.text = "";
    csController.text = "Civil Status";
  }

  @override
  void initState() {
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
              SizedBox(height: 15),
              buildProfileInfo(),
              SizedBox(height: 15),
              buildRegister(context),
            ],
          ),
        ),
      ),
    );
  }
}

@override
void initState() {}
