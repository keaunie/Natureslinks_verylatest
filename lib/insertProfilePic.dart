import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:objectid/objectid.dart' as sup;
import 'globals.dart' as globals;

class insertProfilePic extends StatefulWidget {
  const insertProfilePic({Key? key}) : super(key: key);

  @override
  State<insertProfilePic> createState() => _insertProfilepicState();
}

class _insertProfilepicState extends State<insertProfilePic> {
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
                  'Change Profile Picture',
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

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String selected = 'Select File';
  String textHolder = '';
  String uploadedfile = '';


  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg', 'webp']);
    if (result == null) return;

    setState(() {

      pickedFile = result.files.first;
      selected = pickedFile!.name;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Uploading File!')));
    final snapshot = await uploadTask!.whenComplete(() {});

    uploadedfile = await snapshot.ref.getDownloadURL();
    _insertpicdata(uploadedfile);
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Download Link: $uploadedfile')));
    // Navigator.pop(context);
    setState(() {
      uploadTask = null;
    });
  }

  Future<void> _insertpicdata(
    String link,
  ) async {
    print(uploadedfile);
    var result = await MongoDatabase.uploadProfilep(uploadedfile);
    var allUserInfos = await MongoDatabase.userCollection
        .find({'email': globals.email}).toList();
    var anything = allUserInfos.toString();
    var therefore = anything.replaceAll("[]", "");
    final List<dynamic> dataList = allUserInfos;
    final item = dataList[0];
    globals.profilepic = item['profilepic'];
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profile picture changed!')));
    Navigator.pop(context);
    // print(therefore);
    // print(result);
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
              ElevatedButton(onPressed: selectFile, child: Text('$selected')),
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
          if (pickedFile == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Choose image from your gallery")));
          } else {
            uploadFile();
            // print(uploadedfile);
            //
            // _insertCS(supportId,titleController.text, descriptionController.text, globals.fName!, globals.uid!);
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("We thank you for your support!")));
            // Navigator.pop(context);
          }
        },
        child: Text(
          'Upload Profile Picture',
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
