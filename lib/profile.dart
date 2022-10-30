import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getInfos();
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideo() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover),
      ),
    );
  }

  // String uid = '';
  // Future getInfos() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? fName = prefs.getString('fName');
  //   String? mName = prefs.getString('mName');
  //   String? lName = prefs.getString('lName');

  //   return (fName);
  // }

  Widget buildProfileInfo(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizedBox spacer = SizedBox(height: 20);
    return Container(
      width: size.width,
      height: size.height / 2,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  globals.fName!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  globals.mName!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  globals.lName!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Gender: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    globals.gender!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              spacer,
              Row(
                children: [
                  Text(
                    "Religion: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    globals.religion!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              spacer,
              Row(
                children: [
                  Text(
                    "Birthday: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    globals.bday!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              spacer,
              Row(
                children: [
                  Text(
                    "Address: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    globals.addr!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              spacer,
              Row(
                children: [
                  Text(
                    "Civil Status: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    globals.civilStats!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLogoutBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red[400],
        ),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => route.isFirst);
        },
        child: Text(
          'Log Out',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                fit: BoxFit.contain)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
          child: Column(
            children: <Widget>[
              buildHeader(context),
              SizedBox(height: 20),
              buildVideo(),
              SizedBox(height: 15),
              buildProfileInfo(context),
              SizedBox(height: 15),
              buildLogoutBtn(context),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

