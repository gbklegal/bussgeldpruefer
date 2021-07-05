import 'package:app/helper/helperfunctions.dart';
import 'package:app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount _user;
  GoogleSignInAccount get user => _user;

  Future googleLogin(_token) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    //notifyListeners();

    Map<String, String> userInfoMap = {
      "name": _user.displayName,
      "email": _user.email,
      "token": _token
    };
    HelperFunctions().saveUserEmailSharedPreference(_user.email);
    HelperFunctions().saveUserNameSharedPreference(_user.displayName);

    HelperFunctions().saveUserLoggedInSharedPreference(true);
    DatabaseMethods().addUserInfo(userInfoMap);
  }
}
