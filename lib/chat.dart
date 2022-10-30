import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:natureslink/chatroom.dart';
import 'package:natureslink/home.dart';
import 'package:natureslink/globals.dart' as globals;


class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _MainChatAppStreamState createState() => _MainChatAppStreamState();
}

class _MainChatAppStreamState extends State<Chat> {
  void initState() {}

  Widget buildSchedule(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: const Text("Cancel"),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Book an Appointment",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 800,
            )
          ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.black45),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
              ),
              Container(
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: <Widget>[
                    Chatroom(),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
