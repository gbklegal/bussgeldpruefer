import 'dart:async';
import 'dart:convert';

import 'package:app/helper/helperfunctions.dart';
import 'package:app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final List<String> users;
  ConversationScreen(this.chatRoomId, this.users);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageEditingController = new TextEditingController();
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  Stream<QuerySnapshot> chats;
  ScrollController _controller = ScrollController();
  bool _value = false;
  String myEmail, userEmail, userToken;

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    myEmail = await HelperFunctions().getUserEmailSharedPreference();
    userEmail =
        await _databaseMethods.getUserEmail(widget.chatRoomId, myEmail.trim());
    userToken = await _databaseMethods.getUserToken(userEmail);
  }

  chatInputField() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: messageEditingController,
                        onChanged: (messageEditingController) {
                          setState(() {
                            if (messageEditingController.isEmpty) {
                              _value = false;
                            } else
                              _value = true;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  sendMessage();
                  _value = false;
                });
              },
              child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(12),
                  child: getSendButton()),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSendButton() {
    if (_value) {
      return Image.asset(
        "assets/images/icons/send.png",
        height: 25,
        width: 25,
      );
    } else {
      return Image.asset(
        "assets/images/icons/hollow_send.png",
        height: 25,
        width: 25,
      );
    }
  }

  sendMessage() async {
    if (messageEditingController.text.isNotEmpty) {
      print(widget.users);
      Map<String, dynamic> chatMessageMap = {
        "sendBy": widget.users[0],
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
        'isRead': false
      };

      _databaseMethods.addUserMessages(widget.chatRoomId, chatMessageMap);

      sendNotificationMessageToPeerUser(
          messageEditingController.text, widget.users[0], userToken);
      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  AppBar buildAppBar() {
    return AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.users[1],
          style: TextStyle(color: Colors.black, fontSize: 16),
        ));
  }

  Future<void> sendNotificationMessageToPeerUser(
      textFromTextField, myName, peerUserToken) async {
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try {
      await http.post(
        // 'https://fcm.googleapis.com/fcm/send',
        // 'https://api.rnfirebase.io/messaging/send',
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$firebaseCloudserverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': '$textFromTextField',
              'title': '$myName',
              //'badge':'$unReadMSGCount',//'$unReadMSGCount'
              "sound": "default",
              //"image" : myImageUrl
            },
            'priority': 'high',
            // 'data': <String, dynamic>{
            //   'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            //   'id': '1',
            //   'status': 'done',
            //   'chatroomid': chatID,
            //   'userImage':myImageUrl,
            //   'userName':'$myName',
            //   'message': messageType == 'text' ? '$textFromTextField' : '(Photo)',
            // },
            'to': peerUserToken,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.docs.length);
          Timer(
            Duration(microseconds: 0),
            () => _controller.jumpTo(_controller.position.maxScrollExtent),
          );
          return ListView.builder(
              shrinkWrap: true,
              controller: _controller,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return MessageTile(
                  message: snapshot.data.docs[index]["message"],
                  sendByMe:
                      widget.users[0] == snapshot.data.docs[index]["sendBy"],
                );
              });
        } else
          return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(),
        body: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: chatMessages()),
            ),
            chatInputField(),
          ],
        ));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 16, right: sendByMe ? 16 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),
        decoration: sendByMe
            ? BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
                gradient: LinearGradient(
                  colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
                ))
            : BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: sendByMe ? Colors.white : Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
