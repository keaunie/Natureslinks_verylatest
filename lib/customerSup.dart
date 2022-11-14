import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';

class customerSup extends StatefulWidget {
  const customerSup({Key? key}) : super(key: key);

  @override
  State<customerSup> createState() => _customerSupState();
}

class _customerSupState extends State<customerSup> {

  static Future<List<Map<String, dynamic>>> fetchSups() async {
    final arrData = await customerSupport.customerSupportCollection.find()
        .toList();
    print(arrData);
    return arrData;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: fetchSups(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totalData = snapshot.data.length;
                    print("Total Data: " + totalData.toString());
                    if (totalData == 0) {
                      return Center(
                        child: Column(
                          children: [
                            Spacer(),
                            Text('Congrats!',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            Text('No customer problems YET!',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(customerSupportModel.fromJson(
                                snapshot.data[index]));
                          });
                    }
                  } else {
                    return Center(
                      child: Text("No Scheduled yet!"),
                    );
                  }
                }
              }),
        ),
      ),
    );
  }


  Future <void> doneSupport(M.ObjectId supId) async{
    await customerSupport.customerSupportCollection.deleteOne({"supId": supId});
  }

  String? gchat;

  Widget displayCard(customerSupportModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [

            SizedBox(
              height: 10,
            ),
            Text("${data.title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Text("${data.description}"),
            SizedBox(
              height: 10,
            ),
            Text("By: "+"${data.uname}"),
            SizedBox(
              height: 10,
            ),
            // Text("${data.supId}"),
            // SizedBox(
            //   height: 10,
            // ),
            // Text("${data.status}"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: (){
                setState(() {});
                doneSupport(data.supId);
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}