import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:natureslink/globals.dart' as globals;

class setTime extends StatefulWidget {
  const setTime({Key? key}) : super(key: key);

  @override
  State<setTime> createState() => _setTimeState();
}

class _setTimeState extends State<setTime> {
  String? timeSelected = '';

  bool AM = true;
  bool PM = false;

  void morning(){
    setState(() {
      AM = true;
      PM = false;
    });
  }

  void afternoon(){
    setState(() {
      AM = false;
      PM = true;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
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
                    'Time Available',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  ToggleSwitch(
                    minWidth: 50.0,
                    initialLabelIndex: 0,
                    cornerRadius: 10.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.greenAccent,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['AM', 'PM'],
                    activeBgColors: [
                      [Colors.greenAccent],
                      [Colors.greenAccent],
                    ],
                    onToggle: (index) {
                      if (index == 1) {
                        afternoon();
                      } else {
                        morning();
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: AM,
                    child: ToggleSwitch(
                      minWidth: 90.0,
                      initialLabelIndex: 0,
                      cornerRadius: 30.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 3,
                      labels: ['9:30 AM', '10:30 AM', '11:30 AM'],
                      activeBgColors: [
                        [Colors.greenAccent],
                        [Colors.greenAccent],
                        [Colors.greenAccent]
                      ],
                      onToggle: (index) {
                        if (index == 2) {
                          timeSelected = "11:30 AM";
                          globals.selectedTime = timeSelected;
                        } else if (index == 1) {
                          timeSelected = "10:30 AM";
                          globals.selectedTime = timeSelected;
                        } else {
                          timeSelected = "9:30 AM";
                          globals.selectedTime = timeSelected;
                        }
                        print('switched to: $timeSelected');
                      },
                    ),
                  ),
                  Visibility(
                    visible: PM,
                    child: ToggleSwitch(
                      minWidth: 90.0,
                      initialLabelIndex: 0,
                      cornerRadius: 30.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 3,
                      labels: ['1:00 PM', '2:00 PM', '3:00 PM'],
                      activeBgColors: [
                        [Colors.greenAccent],
                        [Colors.greenAccent],
                        [Colors.greenAccent]
                      ],
                      onToggle: (index) {
                        if (index == 2) {
                          timeSelected = "3:00 PM";
                          globals.selectedTime = timeSelected;
                        } else if (index == 1) {
                          timeSelected = "2:00 PM";
                          globals.selectedTime = timeSelected;
                        } else {
                          timeSelected = "1:00 PM";
                          globals.selectedTime = timeSelected;
                        }
                        print('switched to: $timeSelected');
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
