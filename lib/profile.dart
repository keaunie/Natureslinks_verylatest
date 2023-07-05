import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:natureslink/changePassword.dart';
import 'package:natureslink/insertCustomerSupport.dart';
import 'package:natureslink/insertProfilePic.dart';
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
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => {
                Navigator.pop(context),
                setState(() {
                  globals.profilepic;
                })
              },
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            Spacer(),
            Text(
              'My Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildVideo() {
    var profilepic = '';
    print(globals.profilepic);
    if (globals.profilepic == '') {
      profilepic =
          'https://firebasestorage.googleapis.com/v0/b/natureslinks-245ca.appspot.com/o/files%2Fblank-profile-picture-973460_1280.webp?alt=media&token=1992a83c-0cb1-47af-b1f4-9a434ab534ad&_gl=1*1eibm8z*_ga*MTA0NzQ1NjkyOC4xNjYzODQ2OTA1*_ga_CW55HF8NVT*MTY4NjQ3MjQxNC4yMi4xLjE2ODY0NzM5NDcuMC4wLjA.';
    } else {
      profilepic = globals.profilepic!;
    }

    return Card(
      color: Colors.greenAccent,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          // Image.network(profilepic),
          shape: BoxShape.circle,
        ),
        child: Card(
          child: Image.network(
          profilepic,
          fit: BoxFit.fill,
        ),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.all(10),)
      ),
    );
  }

  Widget buildChangePassBtn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => changePassword()));
        },
        child: Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

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
                // Text(
                //   globals.fName!,
                //   style: TextStyle(
                //       color: Colors.black,
                //       // fontSize: MediaQuery.of(context).size.width,
                //       fontWeight: FontWeight.bold),
                // ),
                AutoSizeText(
                  globals.fName! + ' ' + globals.lName!,
                  style: TextStyle(fontSize: 30),
                  minFontSize: 18,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),

                // SizedBox(
                //   width: 15,
                // ),
                // Text(
                //   globals.mName!,
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold),
                // ),
                // AutoSizeText(
                //   globals.mName!,
                //   style: TextStyle(fontSize: 30),
                //   maxLines: 2,
                // ),
                // SizedBox(
                //   width: 15,
                // ),
                // Text(
                //   globals.lName!,
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 40,
                //       fontWeight: FontWeight.bold),
                // ),
                // AutoSizeText(
                //   globals.lName!,
                //   style: TextStyle(fontSize: 30),
                //   maxLines: 2,
                // ),
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
          ),
          Spacer(),
          buildChangePassBtn(),
          // buildCustomerSupportBtn(),
          buildChangeProfileBtn(),
        ],
      ),
    );
  }

  Widget buildCustomerSupportBtn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => insertCustomerSupport()));
        },
        child: Text(
          'Customer Support',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildChangeProfileBtn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => insertProfilePic()));
        },
        child: Text(
          'Change Profile Picture',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                image: AssetImage("assets/images/bg.png"),
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
