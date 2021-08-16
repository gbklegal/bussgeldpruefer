import 'dart:convert';

import 'package:app/helper/helperfunctions.dart';
import 'package:app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount _user;
  GoogleSignInAccount get user => _user;

  static Map<String, dynamic> parseJwt(String token) {
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }

  Future googleLogin(_token) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Map<String, dynamic> idMap = parseJwt(googleAuth.idToken);
    final String firstName = idMap["given_name"];
    final String lastName = idMap["family_name"];

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.additionalUserInfo.isNewUser) {
      var totalUsers = await DatabaseMethods().getTotalUsers();
      var _id = totalUsers - 1;
      var userInfoMap = {
        "id": FirebaseAuth.instance.currentUser.uid,
        "name": {"first": firstName, "last": lastName},
        "email": _user.email,
        "FCMtoken": _token,
      };
      DatabaseMethods().addUserInfo(userInfoMap, totalUsers);
      HelperFunctions().saveValues(firstName, lastName, _user.email);
    } else {
      HelperFunctions().saveValues(firstName, lastName, _user.email);
    }
  }
}
