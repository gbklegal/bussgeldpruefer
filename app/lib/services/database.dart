import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  firebase_storage.Reference ref;
  String _fileURLs;

  Future<void> addUserInfo(userData, noOfUsers, id) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(id.toString())
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
    setTotalUsers(noOfUsers);
  }

  Future<int> getTotalUsers() async {
    int totalUsers = 0;
    var userQuery = await FirebaseFirestore.instance
        .collection("totalusers")
        .doc('All Users')
        .get();
    if (userQuery.exists) {
      totalUsers = userQuery.get('totalUsers');
      totalUsers++;
      return totalUsers;
    } else {
      return 1;
    }
  }

  Future<void> setTotalUsers(noOfUsers) async {
    Map<String, dynamic> data = <String, dynamic>{"totalUsers": noOfUsers};
    await FirebaseFirestore.instance
        .collection("totalusers")
        .doc('All Users')
        .set(data);
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

  Future<void> updateUserToken(token) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser.uid)
        .update({
      'FCMtoken': token.toString(),
    });
  }

  Future<String> getUserToken(email) async => await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        return value.docs[0]['FCMtoken'].toString();
      });

  getUserChats(String itIsMyName) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  Future<String> getUserEmail(String chatRoomId, String myEmail) async =>
      FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(chatRoomId)
          .get()
          .then((value) {
        if (value['usersEmails'][0].toString() == myEmail) {
          return value['usersEmails'][1].toString();
        } else {
          return value['usersEmails'][0].toString();
        }
      });

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future uploadFile(file) async {
    var totalOrders = await getTotalOrderNumbers();
    var orderNumber = "2021" + totalOrders.toString().padLeft(4, '0');
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('signatures/${Path.basename(file.path)}');
    await ref.putFile(file).whenComplete(() async {
      _fileURLs = await ref.getDownloadURL();
    });
    _add(orderNumber, totalOrders);
  }

  Future<int> getTotalOrderNumbers() async {
    int totalOrders = 0;
    var userQuery = await FirebaseFirestore.instance
        .collection("totalorders")
        .doc('All Order Numbers')
        .get();
    if (userQuery.exists) {
      totalOrders = userQuery.get('totalOrders');
      totalOrders++;
      return totalOrders;
    } else {
      return 1;
    }
  }

  Future<void> setTotalOrderNumbers(noOfOrders) async {
    Map<String, dynamic> data = <String, dynamic>{"totalOrders": noOfOrders};
    await FirebaseFirestore.instance
        .collection("totalorders")
        .doc('All Order Numbers')
        .set(data);
  }

  Future<void> _add(orderNumber, totalOrders) async {
    Map<String, dynamic> data = <String, dynamic>{"signatureFile": _fileURLs};
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderNumber)
        .set(data);
    _fileURLs = null;
    setTotalOrderNumbers(totalOrders);
  }
}
