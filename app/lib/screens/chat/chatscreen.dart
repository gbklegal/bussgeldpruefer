import 'dart:math';
import 'package:app/helper/helperfunctions.dart';
import 'package:app/screens/messages/conversationscreen.dart';
import 'package:app/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

List<String> usersOfChats = [];
String userEmail;

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId;
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  final TextEditingController _typeAheadController = TextEditingController();
  String myUserName;
  String myEmail;
  Stream chatRooms;

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
    });
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.docs[index]['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(myUserName, ""),
                    chatRoomId: snapshot.data.docs[index]["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  getUserInfogetChats() async {
    myUserName = await HelperFunctions().getUserNameSharedPreference();
    myEmail = await HelperFunctions().getUserEmailSharedPreference();
    DatabaseMethods().getUserChats(myUserName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${myUserName.toString()}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TypeAheadField(
                debounceDuration: Duration(milliseconds: 500),
                textFieldConfiguration: TextFieldConfiguration(
                  controller: this._typeAheadController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => _typeAheadController.clear(),
                      icon: Icon(Icons.highlight_remove_rounded),
                    ),
                    //Icon(Icons.close),
                    hintText: 'Search Username',
                  ),
                ),
                itemBuilder: (context, suggestion) {
                  if (suggestion['email'] == myEmail) {
                    return const SizedBox();
                  } else
                    return ListTile(
                      title: Text(suggestion['name']),
                      leading: CircleAvatar(
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        foregroundColor: Colors.white,
                        child: Text(
                          suggestion['name'].substring(0, 1).toUpperCase(),
                        ),
                      ),
                    );
                },
                onSuggestionSelected: (suggestion) {
                  //this._typeAheadController.text = suggestion['name'];
                  sendMessage(
                      suggestion['name'].trim(), suggestion['email'].trim());
                  userEmail = suggestion['email'].trim();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversationScreen(chatRoomId, usersOfChats),
                      ));
                  //_reciever = suggestion['email'];
                },
                noItemsFoundBuilder: (context) => Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          'No Users Found.',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                suggestionsCallback: (pattern) async {
                  return await _databaseMethods.getSuggestions(pattern);
                }),
          ),
          Container(child: chatRoomsList()),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.blue,
      //   child: Icon(
      //     Icons.person_add_alt_1,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Chats",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.search),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  sendMessage(String userName, String _userEmail) {
    usersOfChats = [];
    List<String> users = [myUserName, userName];
    List<String> usersEmails = [myEmail, _userEmail];
    print("I am : " + myUserName.toString() + " Other is : " + userName);
    usersOfChats = users;
    chatRoomId = getChatRoomId(myUserName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
      "usersEmails": usersEmails
    };

    _databaseMethods.addChatRoom(chatRoom, chatRoomId);
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  getUserInfo() async {
    usersOfChats = [
      await HelperFunctions().getUserNameSharedPreference(),
      userName
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getUserInfo();
        print(userName);
        print(chatRoomId + usersOfChats.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConversationScreen(chatRoomId, usersOfChats)));
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ListTile(
          title: Text(userName),
          leading: CircleAvatar(
            backgroundColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
            foregroundColor: Colors.white,
            child: Text(
              userName.substring(0, 1).toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }
}
