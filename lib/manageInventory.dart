import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/globals.dart';
import 'package:natureslink/home.dart';
import 'package:natureslink/productInfo.dart';
import 'package:natureslink/videoList.dart';
import 'package:natureslink/videosTutorial.dart';
import 'globals.dart' as globals;

class manageInventory extends StatefulWidget {
  const manageInventory({Key? key}) : super(key: key);

  @override
  State<manageInventory> createState() => _manageInventoryState();
}

class _manageInventoryState extends State<manageInventory> {
  var linkController = new TextEditingController();
  var titleController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var priceController = new TextEditingController();
  var stockController = new TextEditingController();

  var linkControllernull = new TextEditingController();
  var titleControllernull = new TextEditingController();
  var descriptionControllernull = new TextEditingController();
  var priceControllernull = new TextEditingController();
  var stockControllernull = new TextEditingController();

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
                  'Insert Products',
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

  // Future uploadFile() async {
  //   final path = 'files/${pickedFile!.name}';
  //   final file = File(pickedFile!.path!);
  //
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   setState(() {
  //     uploadTask = ref.putFile(file);
  //   });
  //
  //   textHolder = 'Uploading';
  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(content: Text('Uploading File!')));
  //   final snapshot = await uploadTask!.whenComplete(() {});
  //
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //
  //   if(urlDownload == '' || urlDownload == null){
  //     // _insertProdData(prodID!, productLink!, name!, price!, stock!, details!, DateTime.now());
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Download Link: $urlDownload')));
  //     // productLink = '';
  //     // name = '';
  //     // price = '';
  //     // stock = '';
  //     // details = '';
  //
  //
  //     products.productCollection.updateOne(M.where.eq('_id', prodID), M.modify.set('name', name));
  //     products.productCollection.updateOne(M.where.eq('_id', prodID), M.modify.set('price', price));
  //     products.productCollection.updateOne(M.where.eq('_id', prodID), M.modify.set('stock', stock));
  //     products.productCollection.updateOne(M.where.eq('_id', prodID), M.modify.set('details', details));
  //     Navigator.pop(context);
  //     setState(() {
  //       pickedFile = null;
  //       loading = false;
  //       uploadTask = null;
  //     });
  //   }else{
  //     _insertProdData(prodID!, productLink!, name!, price!, stock!, details!, DateTime.now());
  //     print(name);
  //     // _insertProdData(prodID!, urlDownload, name!, price!, stock!, details!, DateTime.now());
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Download Link: $urlDownload')));
  //     products.productCollection.updateOne(M.where.eq('_id', prodID), M.modify.set('name', titleController.text));
  //     Navigator.pop(context);
  //
  //
  //     setState(() {
  //       productLink = '';
  //       name = '';
  //       price = '';
  //       stock = '';
  //       details = '';
  //       loading = false;
  //       uploadTask = null;
  //     });
  //   }
  //
  // }

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


    _insertProdData(prodID!, productLink!, name!, price!, stock!, details!, DateTime.now());
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

  String selected = 'Select Image';

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

  Future<void> _insertProdData(
      M.ObjectId id,
    String link,
    String name,
    String price,
    String stock,
    String details,
    DateTime postDate,
  ) async {
    final prodData = productsModel(
      id: id,
      productLink: link,
      name: name,
      price: price,
      stock: stock,
      details: details,
      path: "",
      postDate: postDate,
    );
    var result = await products.insertProd(prodData);
    print(result);
  }

  Widget buildProductInfo() => Card(
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

              ElevatedButton(onPressed: selectFile, child: Text('$selected')),
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
              TextField(
                controller: priceController,
                decoration: (InputDecoration(labelText: "Price: ")),
              ),
              TextField(
                controller: stockController,
                decoration: (InputDecoration(labelText: "Stock/s: ")),
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  children: [
                    Text('$textHolder', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: 10,
                    ),
                    Visibility(
                      visible: loading,
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      );

  static Future<List<Map<String, dynamic>>> fetchInventory() async {
    final arrData = await products.productCollection.find().toList();
    print(arrData);
    return arrData;
  }

  _showSimpleModalDialog(context) async {
    titleController.text = name!;
    descriptionController.text = details!;
    priceController.text = price!;
    stockController.text = stock!;


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Update Info',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: selectFile, child: Text('$selected')),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: titleController,
                            decoration: (InputDecoration(labelText: "Title: ")),
                          ),
                          TextField(
                            controller: descriptionController,
                            minLines: 3,
                            maxLines: 50,
                            decoration:
                                (InputDecoration(labelText: "Description: ")),
                          ),
                          TextField(
                            controller: priceController,
                            decoration: (InputDecoration(labelText: "Price: ")),
                          ),
                          TextField(
                            controller: stockController,
                            decoration:
                                (InputDecoration(labelText: "Stock/s: ")),
                          ),
                          Center(
                            child: Row(
                              children: [
                                Text('$textHolder',
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  width: 10,
                                ),
                                Visibility(
                                  visible: loading,
                                  child: LoadingAnimationWidget.prograssiveDots(
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                          ),
                          buildInsertVid(),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  String? gchat;
  String? name, productLink, price, stock, details;
  M.ObjectId? prodID;

  Widget displayCard(productsModel data) {
    gchat = "${data.name}";
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Image.network(
              data.productLink,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${data.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            // Text("${data.description}"),
            SizedBox(
              height: 10,
            ),
            // Text("${data.doctor}"),
            // SizedBox(
            //   height: 10,
            // ),
            // Text("${data.status}"),
            // SizedBox(
            //   height: 10,
            // ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
              onPressed: () {
                setState(() {
                  prodID = data.id;
                  name = data.name;
                  productLink = data.productLink;
                  price = data.price;
                  stock = data.stock;
                  details = data.details;

                });
                _showSimpleModalDialog(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         decoration:
//             const BoxDecoration(image: DecorationImage(image: AssetImage("""
// assets/images/bg.png"""), fit: BoxFit.cover)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               buildHeader(context),
//               SizedBox(height: 20),
//               buildProductInfo(),
//               SizedBox(height: 20),
//               buildInsertVid(),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           decoration:
//           const BoxDecoration(image: DecorationImage(image: AssetImage("""
// assets/images/bg.png"""), fit: BoxFit.cover)),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: FutureBuilder(
//                   future: fetchVideos(),
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else {
//                       if (snapshot.hasData) {
//                         var totalData = snapshot.data.length;
//                         print("Total Data: " + totalData.toString());
//                         if (totalData == 0) {
//                           return Center(
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (context) =>
//                                               Home()));
//                                     },
//                                     child: Container(
//                                       child: Column(
//                                         children: [
//                                           Text('No Schedule Yet!',
//                                             style: TextStyle(
//                                               fontSize: 30,
//                                             ),
//                                           ),
//                                           Text('Get Your Schedule Here!',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.blue
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )),
//                                 Spacer(),
//                               ],
//                             ),
//                           );
//                         } else {
//                           return ListView.builder(
//                               itemCount: snapshot.data.length,
//                               itemBuilder: (context, index) {
//                                 return displayCard(videoTutModel.fromJson(snapshot.data[index]));
//                               });
//                         }
//                       } else {
//                         return Center(
//                           child: Text("No Internet connection"),
//                         );
//                       }
//                     }
//                   }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Column(
          children: [
            buildProductInfo(),
            buildInsertVid(),
            Container(
              decoration:
                  const BoxDecoration(image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover)),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                color: Color.fromRGBO(46, 136, 87, 0.4),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FutureBuilder(
                      future: fetchInventory(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData) {
                            var totalData = snapshot.data.length;
                            // print("Total Data: " + totalData.toString());
                            if (totalData == 0) {
                              return Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Card(
                                        color: Colors.greenAccent.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Home()));
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'No Schedule Yet!',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Get Your Schedule Here!',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return displayCard(productsModel
                                        .fromJson(snapshot.data[index]));
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
            ),
          ],
        ),
      ),
    );
  }
}
