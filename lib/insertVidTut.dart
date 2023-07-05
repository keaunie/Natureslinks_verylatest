import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/videosTutorial.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class insertVidTut extends StatefulWidget {
  const insertVidTut({Key? key}) : super(key: key);

  @override
  State<insertVidTut> createState() => _insertVidTutState();
}

class _insertVidTutState extends State<insertVidTut> {
  var linkController = new TextEditingController();
  var titleController = new TextEditingController();
  var descriptionController = new TextEditingController();

  var linkControllernull = new TextEditingController();
  var titleControllernull = new TextEditingController();
  var descriptionControllernull = new TextEditingController();

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
                  'Insert Videos',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
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

  String textHolder = '';

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
      selected = pickedFile!.name;
    });
  }

  var loading = false;

  Future uploadFile() async {


    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

textHolder = 'Uploading';
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Uploading File!')));
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();


    _insertVidData(urlDownload, titleController.text,
        descriptionController.text, DateTime.now());
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download Link: $urlDownload')));
    Navigator.pop(context);
    setState(() {
      loading = false;
      uploadTask = null;
    });
  }

  // Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  //     stream: uploadTask?.snapshotEvents,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         final data = snapshot.data!;
  //         double progress = data.bytesTransferred / data.totalBytes;
  //         return Card(
  //           child: Center(
  //             child: Text(
  //               '${(100 * progress).roundToDouble()}%',
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         );
  //       } else {
  //         return const SizedBox(
  //           height: 50,
  //         );
  //       }
  //     });

  String selected = 'Select File';

  Widget buildInsertVid() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () {
          if (titleController.text.isEmpty ||
              descriptionController.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Please Insert Data")));
          } else {
            loading = true;
            uploadFile();
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("Videos Inserted!")));
          }
        },
        child: Text(
          'Insert',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _insertVidData(
      String link,
      String title,
      String overview,
      DateTime postDate,
      ) async {
    final viddata = videoTutModel(
      link: link,
      title: title,
      overview: overview,
      postDate: postDate,
    );
    var result = await videoTutorial.insertVT(viddata);
    print(result);
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
              // if (pickedFile != null)
              //   Expanded(
              //     child: Container(
              //       color: Colors.white,
              //       child: Column(
              //         children: [
              //           Text(pickedFile!.name),
              //         ],
              //       ),
              //     ),
              //   ),

              ElevatedButton(
                  onPressed: selectFile, child: Text('$selected')),
              // ElevatedButton(
              //     onPressed: uploadFile, child: const Text('Upload File')),
              // buildProgress(),

              TextField(
                controller: titleController,
                decoration: (InputDecoration(labelText: "Title: ")),
              ),
              TextField(
                controller: descriptionController,
                minLines: 3,
                maxLines: 20,
                decoration: (InputDecoration(labelText: "Description: ")),
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  children: [
                    Text('$textHolder', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10,),
                    Visibility(
                      visible: loading,
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );


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
