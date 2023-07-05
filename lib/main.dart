
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:natureslink/dbHelper/mongodb.dart';
import 'package:natureslink/splash.dart';

Future main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDatabase.connect();
    await videoTutorial.connectVT();
    await chatAppointments.connectCA();
    await customerSupport.connectCS();
    await announcement.connectA();
    await products.connectProd();
    await Firebase.initializeApp();
    AwesomeNotifications().initialize(null, [
      NotificationChannel(channelKey: 'basic_channel', channelName: 'Basic Notification', channelDescription: 'Test Notification')
    ],
        debug: true
    );
    // await Firebase.initializeApp(
    //     options: FirebaseOptions(
    //       apiKey: "AIzaSyB1LVxpIuvk5TVqruzI_DoRWqZXZ8_WJ4U",
    //       appId: "natureslinks-245ca.firebaseapp.com",
    //       messagingSenderId: "903330401263",
    //       projectId: "natureslinks-245ca",
    //     ));
  }catch(e){
    print(e);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Natureslink',
      theme: ThemeData(),
      home: splashScreen(),

    );
  }
}




class MyHomePage extends StatefulWidget {


  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/m-logo.png',
              width: 500,
              height: 500,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

