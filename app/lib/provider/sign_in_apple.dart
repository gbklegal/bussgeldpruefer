import 'package:app/helper/helperfunctions.dart';
import 'package:app/services/database.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithApple(
      {List<Scope> scopes = const [], String token}) async {
    // 1. perform the sign-in request
    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        var userInfoMap = {
          "id": FirebaseAuth.instance.currentUser.uid,
          "name": {
            "first": appleIdCredential.fullName.givenName,
            "last": appleIdCredential.fullName.familyName
          },
          "email": appleIdCredential.email,
          "FCMtoken": token,
        };
        if (authResult.additionalUserInfo.isNewUser) {
          DatabaseMethods().addUserInfo(userInfoMap);
          HelperFunctions().saveValues(appleIdCredential.fullName.givenName,
              appleIdCredential.fullName.familyName, appleIdCredential.email);
        } else {
          HelperFunctions().saveValues(appleIdCredential.fullName.givenName,
              appleIdCredential.fullName.familyName, appleIdCredential.email);
        }

        if (scopes.contains(Scope.fullName)) {
          final displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateDisplayName(displayName);
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }
}
