import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:objectid/objectid.dart' as sup;
import 'globals.dart' as globals;

class insertCustomerSupport extends StatefulWidget {
  const insertCustomerSupport({Key? key}) : super(key: key);

  @override
  State<insertCustomerSupport> createState() => _insertCustomerSupportState();
}

class _insertCustomerSupportState extends State<insertCustomerSupport> {
  var titleController = new TextEditingController();
  var descriptionController = new TextEditingController();

  Widget buildHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                Spacer(),
                Text(
                  'Customer Supports',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideoInfo() => Card(
    color: Colors.white60,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleController,
            decoration: (InputDecoration(labelText: "Title: ")),
          ),
          TextField(
            controller: descriptionController,
            minLines: 3,
            maxLines: 20,
            decoration: (InputDecoration(labelText: "Review or Issues: ")),
          ),
        ],
      ),
    ),
  );

  Widget buildInsertVid() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () {
          final supportId = M.ObjectId();
          if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Tell us something")));
          } else {
            _insertCS(supportId,titleController.text, descriptionController.text, globals.fName!, globals.uid!);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("We thank you for your support!")));
            Navigator.pop(context);
          }
        },
        child: Text(
          'Send',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _insertCS(
      M.ObjectId supId,
      String title,
      String description,
      String uname,
      M.ObjectId uid,
      ) async {
    final csdata = customerSupportModel(
      supId: supId,
      title: title,
      description: description,
      uname: uname,
      uid: uid
    );
    var result = await customerSupport.insertCS(csdata);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration:
        const BoxDecoration(image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildHeader(context),
              SizedBox(height: 20),
              buildVideoInfo(),
              SizedBox(height: 20),
              buildInsertVid(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
