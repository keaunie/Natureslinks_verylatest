import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natureslink/home.dart';
import 'package:natureslink/splash.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Profile> {
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

  Widget buildProfileInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.5),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Keaunie ',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const Text(
                        'Bravo ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      const Text(
                        'Ting',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Gender: ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Text(
                      'Male',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    const Text(
                      'Age: ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Text(
                      '22',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Civil Status: ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Text(
                      'Single',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    const Text(
                      'Birthdate: ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Text(
                      '08/05/2000',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Mobile no.: ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Text(
                      '09774939050',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    const Text(
                      'Municipality/City: ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Text(
                      'Mandaluyong',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              buildProfileInfo(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
