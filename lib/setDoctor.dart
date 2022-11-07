import 'package:flutter/material.dart';
import 'package:natureslink/globals.dart' as globals;

class setDoctor extends StatefulWidget {
  const setDoctor({Key? key}) : super(key: key);

  @override
  State<setDoctor> createState() => _setDoctorState();
}

class _setDoctorState extends State<setDoctor> {

  var items = [
    'Doc John Francis Bernardo - Cert Acupunturist/ Naturopathic Practioner and Clinician',
    'Mellanie Bernardo - Wellness Admin Shaw Center',
    'Jenelyn Rodriguez - Wellness Officer in Charge Bacoor, Cavite',
    'Mark Kevin Fulminar- Wellness Assistant (Care/Patient Therapy)',
    'Angelo Pilar - Wellness Assistant (Patient Care)',
    'Karen Calces- Wellness Assistant (Patient Care)',
    'Donna Bautista - Wellness OIC Dasma',
    'Maloureen Inocencio - Wellness Asst (Product Promo/Marketing)',
    'Shiela Cedeno- Wellness Assistant (Pain Mgt Therapy)',
    'Raymond Pones-  Wellness Assistant (Patient Care)',
  ];

  String dropdownvalue =
      'Doc John Francis Bernardo - Cert Acupunturist/ Naturopathic Practioner and Clinician';

  var doctorController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Card(
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
                    'Doctors Available',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
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
                                    doctorController.text = dropdownvalue;
                                    globals.selectedDoctor = dropdownvalue;
                                    print(globals.selectedDoctor);
                                  });
                                },
                              ),
                            ],
                          ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
