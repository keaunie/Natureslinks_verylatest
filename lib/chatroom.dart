import 'package:flutter/material.dart';
import 'package:natureslink/doctor.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {


  runApp(
    MainChatAppStream(),
  );
}


class MainChatAppStream extends StatefulWidget  {
  const MainChatAppStream({Key? key}) : super(key: key);

  @override
  State<MainChatAppStream> createState() => _MainChatAppStreamState();
}

class _MainChatAppStreamState extends State<MainChatAppStream> {
  var client = StreamChatClient(
    'h5gk7qby38yd',
    logLevel: Level.INFO,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          client: client,
          child: widget,
        );
      },
      home: Doctor(),
    );
  }
}