import 'package:flutter/material.dart';
import 'package:natureslink/setDoctor.dart';
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
  bool doc = false;

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



  String dropdownvalue2 = 'Services';
  var items2 = [
    'Services',
    'CWD - Chat With Doctor',
    'PMT - Pain Management Therapy',
    'DAC - Detoxification and Cleansing',
    'BET - Bio Energy Therapy',
    'AC1 - Acupuncture',
    'AC2 - Acupressure',
    'IMT - Immuno Therapy',
    'HOM - Homeopathy',
    'NFR - Natural Facial Rejuvination'
  ];



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
                      labels: ['9:00 AM', '10:00 AM', '11:00 AM'],
                      activeBgColors: [
                        [Colors.greenAccent],
                        [Colors.greenAccent],
                        [Colors.greenAccent]
                      ],
                      onToggle: (index) {
                        if (index == 2) {
                          timeSelected = "11AM";
                          globals.selectedTime = timeSelected;
                        } else if (index == 1) {
                          timeSelected = "10AM";
                          globals.selectedTime = timeSelected;
                        } else {
                          timeSelected = "9AM";
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
                          timeSelected = "3PM";
                          globals.selectedTime = timeSelected;
                        } else if (index == 1) {
                          timeSelected = "2PM";
                          globals.selectedTime = timeSelected;
                        } else {
                          timeSelected = "1PM";
                          globals.selectedTime = timeSelected;
                        }
                        print('switched to: $timeSelected');
                      },
                    ),
                  ),
                  //
                  // DropdownButton(
                  //   alignment: Alignment.centerLeft,
                  //   iconSize: 30,
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.black54,
                  //   ),
                  //
                  //   // Initial Value
                  //   value: dropdownvalue,
                  //
                  //   // Down Arrow Icon
                  //   icon: const Icon(Icons.keyboard_arrow_down),
                  //
                  //   // Array list of items
                  //   items: items1.map((String items) {
                  //     return DropdownMenuItem(
                  //       value: items,
                  //       child: Text(items),
                  //     );
                  //   }).toList(),
                  //   // After selecting the desired option,it will
                  //   // change button value to selected value
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownvalue2 = newValue!;
                  //     });
                  //   },
                  // ),
                  DropdownButton(
                    alignment: Alignment.centerLeft,
                    iconSize: 30,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),

                    // Initial Value
                    value: dropdownvalue2,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items2.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {

                      setState(() {
                        dropdownvalue2 = newValue!;
                        globals.selectedAppointedDoctorName = '';
                        globals.titlesu = dropdownvalue2 + " " + timeSelected!;

                        if(dropdownvalue2 == 'CWD - Chat With Doctor'){
                          globals.servicesu = 'CWD';
                        }else if(dropdownvalue2 == 'PMT - Pain Management Therapy'){
                          globals.servicesu = 'PMT';
                        }else if(dropdownvalue2 == 'DAC - Detoxification and Cleansing'){
                          globals.servicesu = 'DAC';
                        }else if(dropdownvalue2 == 'BET - Bio Energy Therapy'){
                          globals.servicesu = 'BET';
                        }else if(dropdownvalue2 == 'AC1 - Acupuncture'){
                          globals.servicesu = 'AC1';
                        }else if(dropdownvalue2 == 'AC2 - Acupressure'){
                          globals.servicesu = 'AC2';
                        }else if(dropdownvalue2 == 'IMT - Immuno Therapy'){
                          globals.servicesu = 'IMT';
                        }else if(dropdownvalue2 == 'HOM - Homeopathy'){
                          globals.servicesu = 'HOM';
                        }else if(dropdownvalue2 == 'NFR - Natural Facial Rejuvination'){
                          globals.servicesu = 'NFR';
                        }else{
                          globals.servicesu = "";
                        }

                        if(dropdownvalue2 == 'CWD - Chat With Doctor'){
                          doc = true;
                          print(dropdownvalue2);
                        }else{
                          doc = false;
                        }
                      });

                    },
                  ),

                  Visibility(
                      visible: doc,
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => setDoctor()));
                            },
                            child: Text('List of doctors'),
                          ),
                        ],
                      )
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
