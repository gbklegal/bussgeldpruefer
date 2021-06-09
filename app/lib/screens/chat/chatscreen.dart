import 'dart:math';

import 'package:app/constants.dart';
import 'package:app/helper/helperfunctions.dart';
import 'package:app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'components/body.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  final TextEditingController _typeAheadController = TextEditingController();
  String myUserName;

  @override
  void initState() {
    getMyInfoFromSharedPreference();
    super.initState();
  }

  getMyInfoFromSharedPreference() async {
    myUserName = await HelperFunctions().getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: TypeAheadField(
            debounceDuration: Duration(milliseconds: 500),
            textFieldConfiguration: TextFieldConfiguration(
              controller: this._typeAheadController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search Username',
              ),
            ),
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion['name']),
                leading: CircleAvatar(
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  foregroundColor: Colors.white,
                  child: Text(
                    suggestion['name'].substring(0, 1).toUpperCase(),
                  ),
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              this._typeAheadController.text = suggestion['name'];
              sendMessage(suggestion['name'].trim().toString());
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
        //   child: Column(
        //     children: [
        //       Expanded(
        //         child: ListView.builder(
        //           itemCount: chatsData.length,
        //           itemBuilder: (context, index) => ChatCard(
        //             chat: chatsData[index],
        //             press: () => Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => MessagesScreen(),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Chats",
        textAlign: TextAlign.center,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  sendMessage(String userName) {
    List<String> users = [myUserName.trim(), userName];
    print("I am : " + myUserName.toString() + " Other is : " + userName);
    String chatRoomId = getChatRoomId(myUserName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    _databaseMethods.addChatRoom(chatRoom, chatRoomId);

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Chat(
    //               chatRoomId: chatRoomId,
    //             )));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
