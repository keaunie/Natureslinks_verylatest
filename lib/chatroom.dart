import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'globals.dart' as globals;

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  var client = StreamChatClient('ekdrhzknqpwm', logLevel: Level.INFO);
  var channel;

  void initdata() async {
    await client.connectUser(
        User(id: globals.user!), client.devToken(globals.user!).rawValue);
    channel = client.channel('messaging', id: 'FlutterDevs');
    await channel.watch();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamChat(
        client: client,
        child: StreamChannel(
          channel: channel,
          child: ChannelPage(),
        ));
  }
}

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(),
        ],
      ),
    );
  }
}
