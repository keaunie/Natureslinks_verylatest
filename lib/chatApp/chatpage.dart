
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:http/http.dart' as http;
import 'package:natureslink/globals.dart' as globals;
class ChatScreen extends StatefulWidget {
  final friendUid;
  final friendName;
  final currentUserName;
  const ChatScreen(
      {Key? key, required this.friendUid, required this.friendName,required this.currentUserName})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState(friendUid, friendName,currentUserName);
}

class _ChatScreenState extends State<ChatScreen> {
  final String friendUid;
  final String friendName;
  final String currentUserName;
  var currentUserId = globals.uid.toString();
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");
  var chatDocId;
  var _textController = new TextEditingController();
  _ChatScreenState(this.friendUid, this.friendName,this.currentUserName);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }


  void checkUser() async {
    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            chatDocId = querySnapshot.docs.single.id;

          });

        } else {

          await chats.add({
            'users': {currentUserId: null, friendUid: null},
            'names':{currentUserId:globals.fName.toString(),friendUid:friendName }
          }).then((value)  {
            setState(() {
              chatDocId = value.id;
            });
          });

        }
      },
    )
        .catchError((error) {});

  }

  void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName':friendName,
      'msg': msg,
      'button': false
    }).then((value) {
      _textController.text = '';
    });

  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('$friendName',style: TextStyle(fontFamily: 'Poppins',color: Colors.black,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(onPressed: ()=> Navigator.pop(context),
            color: Colors.black,
          )),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("chats")
              .doc(chatDocId)
              .collection('messages')
              .orderBy('createdOn', descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"),);
                }
                if (snapshot.hasData) {
                  var data;
                  return SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            reverse: true,
                            children: snapshot.data!.docs.map(
                                  (DocumentSnapshot document) {
                                data = document.data()!;
                                print(data['uid'].toString());
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ChatBubble(
                                        clipper: ChatBubbleClipper6(
                                          nipSize: 3,
                                          radius: 20,
                                          type: isSender(data['uid'].toString())
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble,
                                        ),
                                        alignment: getAlignment(data['uid'].toString()),
                                        margin: EdgeInsets.only(top: 15,left: 10),
                                        backGroundColor: isSender(data['uid'].toString())
                                            ? Color(0xFF08C187)
                                            : Color(0xffE7E7ED),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                            MediaQuery.of(context).size.width * 0.7,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(data['msg'],
                                                        style: TextStyle(fontFamily: 'Poppins',fontSize: 16,
                                                            color: isSender(
                                                                data['uid'].toString())
                                                                ? Colors.white
                                                                : Colors.black),
                                                        maxLines: 100,
                                                        overflow: TextOverflow.ellipsis),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    data['createdOn'] == null
                                                        ? DateTime.now().toString()
                                                        : data['createdOn']
                                                        .toDate()
                                                        .toString(),
                                                    style: TextStyle(fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                        color: isSender(
                                                            data['uid'].toString())
                                                            ? Colors.white
                                                            : Colors.black),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    data['button'] == true ? Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ChatBubble(
                                        clipper: ChatBubbleClipper6(
                                          nipSize: 3,
                                          radius: 20,
                                          type: isSender(data['uid'].toString())
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble,
                                        ),
                                        alignment: getAlignment(data['uid'].toString()),
                                        margin: EdgeInsets.only(top: 15,left: 10),
                                        backGroundColor: isSender(data['uid'].toString())
                                            ? Color(0xFF08C187)
                                            : Color(0xffE7E7ED),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                            MediaQuery.of(context).size.width * 0.7,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: TextButton(onPressed: (){
                                                      // _launchMaps(data['latitude'],data['longitude']);
                                                    },
                                                        child: Text("Click here to get my location",
                                                            style: TextStyle(fontFamily: 'Poppins',fontSize: 16,
                                                                color: isSender(
                                                                    data['uid'].toString())
                                                                    ? Colors.white
                                                                    : Colors.black),
                                                            maxLines: 100,
                                                            overflow: TextOverflow.ellipsis)),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    data['createdOn'] == null
                                                        ? DateTime.now().toString()
                                                        : data['createdOn']
                                                        .toDate()
                                                        .toString(),
                                                    style: TextStyle(fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                        color: isSender(
                                                            data['uid'].toString())
                                                            ? Colors.white
                                                            : Colors.black),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ): Container()
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          color: Color(0xFFECECEC),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: CupertinoTextField(
                                    controller: _textController,
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                  child: Icon(Icons.send,color: Colors.black,size: 30,),
                                  onPressed: () => sendMessage(_textController.text))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }else{
                  return CircularProgressIndicator();
                }
            }
          }
      ),
    );}
}