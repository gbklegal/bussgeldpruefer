import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name;
  String email;

  UserData({this.name, this.email});

  fromMap(Map<String, dynamic> data) {
    this.name = data["name"];
    this.email = data["email"];
  }
}

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) =>
      FirebaseFirestore.instance.collection("users").get().then((snap) {
        return List.of(snap.docs).where((user) {
          final userLower = user['name'].toString().toLowerCase();
          final queryLower = suggestion.toLowerCase();

          return userLower.contains(queryLower);
        }).toList();
      });

  // static Future<List<UserData>> getUsersList() async {
  //   var userData = new UserData();
  //   List<UserData> allData = [];
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data());
  //       userData.fromMap(result.data());
  //       allData.add(userData);
  //       print(userData.name);
  //     });
  //   });
  //   return List.of(userData).toList();
  // }

  addChatRoom(chatRoom, chatRoomId) async {
    // return FirebaseFirestore.instance
    //     .collection("chatRoom")
    //     .doc(chatRoomId)
    //     .set(chatRoom)
    //     .catchError((e) {
    //   print(e);
    // });
    final snapShot = await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .get();
    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRoomId)
          .set(chatRoom);
    }
  }

  addUserMessages(chatRoomId, chatMessageData) async {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }
}
