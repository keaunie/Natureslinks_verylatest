import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/home.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/dbHelper/constant.dart';
import 'package:natureslink/signup.dart';
import 'package:natureslink/userInfoDisplay.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var userController = new TextEditingController();
var passController = new TextEditingController();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRememberMe = false;

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: userController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Color(0xff000000),
                ),
                hintText: 'Username/Email',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: passController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.password,
                  color: Color(0xff000000),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () => print("Forgot Password Pressed"),
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget registerBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () => print("Forgot Password Pressed"),
          child: Text(
            'Register here!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Signup()))
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: 'Sign Up here!',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
      ])),
    );
  }

  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () {
          loginUser();
          // if (kuhaNgData() == 'true') {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => Home()));
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text("Wrong Username or Password")));
          // }
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> kuhaNgData(String user, String pass) async {
    // print(await MongoDatabase.userCollection.find({'user': userController.text})
    //     .toList());
    var allUserInfos = await MongoDatabase.userCollection
        .find({'user': user, 'pass': pass}).toList();
    // var usersName = await MongoDatabase.userCollection.findOne({'user': user});
    var anything = allUserInfos.toString();
    var therefore = anything.replaceAll("[]", "");
    // var something = therefore.replaceAll("{}", "");
    // print(something);
    // print(usersName);
    if (therefore.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wrong Username or Password")));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

      // prefs.setString('uid', userfetch.uid);
      // prefs.setString('userName', userfetch.userName);
      // userInfos = prefs.getString('userinfo').toString();
    }
  }

  // Widget setter() {
  //   return FutureBuilder(
  //       future: MongoDatabase.getData(),
  //       builder: (context, AsyncSnapshot snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else {
  //           if (snapshot.hasData) {
  //             var totalData = snapshot.data.length;
  //             print("Total Data: " + totalData.toString());
  //             return ListView.builder(
  //                 itemCount: snapshot.data.length,
  //                 itemBuilder: (context, index) {
  //                   return displayCard(
  //                       MongoDbModel.fromJson(snapshot.data[index]));
  //                 });
  //           } else {
  //             return Center(
  //               child: Text("No Data Available"),
  //             );
  //           }
  //         }
  //       });
  // }

  Widget displayCard(MongoDbModel data) {
    Future<void> getInfos() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userName', "${data.userName}");
      prefs.setString('firstName', "${data.firstName}");
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("${data.userName}"),
            Text("${data.firstName}"),
            Text("${data.middleName}"),
            Text("${data.lastName}"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getInfos();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  MongoDbModel user = MongoDbModel(
      email: 'adrian@gmail.com',
      userName: '',
      password: 'Hatdog!123',
      firstName: '',
      middleName: '',
      lastName: '',
      address: '',
      birthday: '',
      gender: '',
      religion: '',
      civilStatus: '');

  Future loginUser() async {
    try {
      Map data = {
        "email": user.email,
        "password": user.password,
      };
      String body = json.encode(data);
      final response = await http.post(
        Uri.parse('https://core-remedies.herokuapp.com/auth/login'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: body,
      );
      print(response);
      print(response.statusCode);
      print(json.decode(response.body));
      if (json.decode(response.body) != null && response.statusCode == 200) {
        MongoDbModel userfetch = MongoDbModel.fromJson(json.decode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', userfetch.email);
        prefs.setString('user', userfetch.userName);
        prefs.setString('pass', userfetch.password);
        prefs.setString('fName', userfetch.firstName);
        prefs.setString('mName', userfetch.middleName);
        prefs.setString('lName', userfetch.lastName);
        prefs.setString('addr', userfetch.address);
        prefs.setString('birthday', userfetch.birthday);
        prefs.setString('gender', userfetch.gender);
        prefs.setString('religion', userfetch.religion);
        prefs.setString('civilStats', userfetch.civilStatus);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return Home();
          },
        ), (route) => false);
      }
    } catch (e) {
      rethrow;
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x665ac18e),
                        Color(0x995ac18e),
                        Color(0xcc5ac18e),
                        Color(0xff5ac18e),
                      ]),
                  image: DecorationImage(
                      image: AssetImage("assets/images/natureslinklogo.png"),
                      fit: BoxFit.contain),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 50,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 50),
                        buildEmail(),
                        SizedBox(height: 20),
                        buildPassword(),
                        SizedBox(height: 10),
                        buildForgotPassBtn(),
                        buildRememberCb(),
                        // registerBtn(),

                        buildLoginBtn(context),
                        buildSignupBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
