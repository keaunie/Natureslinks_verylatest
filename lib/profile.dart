import 'package:flutter/material.dart';
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





  // Widget displayData(MongoDbModel data){
  //   String uid = "${data.uid}";
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10),
  //       child: Column(
  //         children: [
  //           Text("${data.uid}"),
  //           SizedBox(height: 5,),
  //           Text("${data.firstName}"),
  //           SizedBox(height: 5,),
  //           Text("${data.middleName}"),
  //           SizedBox(height: 5,),
  //           Text("${data.lastName}"),
  //           SizedBox(height: 5,),
  //         ],
  //       )
  //     ),
  //   );
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfos();
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
String uid = '';
  void getInfos() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid').toString();
    print(uid);
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
            child: Column(
              children: <Widget>[
                Text(
                  uid,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Gender: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Male",
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
                    "Roman Catholic",
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
                    "08/05/2000",
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
                    "Mandaluyong City",
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
                    "Single",
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
            ],
          ),
        ),
      ),
    );
  }
}
