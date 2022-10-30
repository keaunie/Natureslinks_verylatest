import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natureslink/home.dart';
import 'package:natureslink/splash.dart';

class Vtutorial extends StatefulWidget {
  const Vtutorial({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Vtutorial> {
  Widget buildVideo() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/video.png"), fit: BoxFit.fill),
        color: Colors.green.withOpacity(0.5),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 120,
      ),
    );
  }

  Widget buildDesc() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
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
                const Text(
                  ' Video Tutorial',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Description here',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ],
        ));
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
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
            ),
            Container(
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
                      'Natureslink',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            buildVideo(),
            SizedBox(height: 15),
            buildDesc(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
