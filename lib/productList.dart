import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:natureslink/chatApp/chatpage.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:natureslink/home.dart';
import 'package:natureslink/productInfo.dart';
import 'package:natureslink/profile.dart';
import 'package:natureslink/setDoctor.dart';
import 'package:natureslink/setTime.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as globals;
import 'videosTutorial.dart';

class productList extends StatefulWidget {
  const productList({Key? key}) : super(key: key);

  @override
  State<productList> createState() => _productListState();
}

class _productListState extends State<productList> {
  static Future<List<Map<String, dynamic>>> fetchProducts() async {
    final arrData = await products.productCollection.find().toList();
    print(arrData);
    return arrData;
  }

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
                Text(
                  'Natureslink',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("""
assets/images/logo.png"""), fit: BoxFit.cover),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: fetchProducts(),
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
                          children: [],
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(
                                productsModel.fromJson(snapshot.data[index]));
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

  String? gchat;

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
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            // Text("${data.description}"),
            SizedBox(
              height: 10,
            ),
            Text("SRP: ₱ ${data.price}", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Text("Stocks left: ${data.stock}"),
            SizedBox(
              height: 10,
            ),

            // Text("${data.status}"),
            // SizedBox(
            //   height: 10,
            // ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                globals.productLink = data.productLink;
                globals.productName = data.name;
                globals.productDetails = data.details;
                globals.productStock = data.stock;
                // globals.watchVid = "${data.link}";
                // globals.titleVid = "${data.title}";
                // globals.descVid = "${data.overview}";
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => productInfo()));
              },
              child: const Text("More Information"),
            ),
          ],
        ),
      ),
    );
  }
}
