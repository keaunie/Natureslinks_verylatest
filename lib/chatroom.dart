import 'package:flutter/material.dart';
import 'package:talkjs_flutter/talkjs_flutter.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  final session = Session(appId: 'tw3pxaaR');
  var me;
  var other;
  var convo;

  void initdata() {
    me = session.getUser(
      id: '123456',
      name: 'Alice',
      email: ['alice@example.com'],
      photoUrl: 'https://talkjs.com/images/avatar-1.jpg',
      welcomeMessage: 'Hey there! How are you? :-)',
      role: 'default',
    );
    session.me = me;
    other = session.getUser(
      id: '654321',
      name: 'Sebastian',
      email: ['Sebastian@example.com'],
      photoUrl: 'https://talkjs.com/images/avatar-5.jpg',
      welcomeMessage: 'Hey, how can I help?',
      role: 'default',
    );
    convo = session.getConversation(
      id: Talk.oneOnOneId(me.id, other.id),
      participants: {Participant(me), Participant(other)},
    );
  }

  @override
  void initState() {
    initdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChatBox(
      session: session,
      conversation: convo,
    );
  }
}
