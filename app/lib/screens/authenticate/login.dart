import 'package:app/provider/google_sign_in.dart';
import 'package:app/helper/helperfunctions.dart';
import 'package:app/screens/authenticate/registeration.dart';
import 'package:app/services/database.dart';
import 'package:app/services/validators.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  QuerySnapshot snapshotUserInfo;

  String _email, _password, _error, _token;
  String error = '';

  _registerOnFirebase() {
    //_firebaseMessaging.subscribeToTopic('all');
    FirebaseMessaging.instance.getToken().then((token) {
      _token = token;
      HelperFunctions().saveUserTokenSharedPreference(token);
      print(token);
    });
  }

  @override
  void initState() {
    _registerOnFirebase();
    super.initState();
  }

  bool validate() {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void login() async {
    if (validate()) {
      try {
        // ignore: unused_local_variable
        final user = (await _auth.signInWithEmailAndPassword(
                email: _email.trim(), password: _password))
            .user;
        QuerySnapshot userInfoSnapshot =
            await DatabaseMethods().getUserInfo(_email.trim());
        print("I am user : " + userInfoSnapshot.docs[0]['name']);
        HelperFunctions().saveUserLoggedInSharedPreference(true);
        HelperFunctions()
            .saveUserNameSharedPreference(userInfoSnapshot.docs[0]['name']);
        // String name;
        // name = await HelperFunctions().getUserNameSharedPreference();
        HelperFunctions()
            .saveUserEmailSharedPreference(userInfoSnapshot.docs[0]['email']);
        HelperFunctions().saveUserLoggedInSharedPreference(true);
        DatabaseMethods().updateUserToken(_token);
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                _error,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  _padding(double _height) {
    return SizedBox(height: _height);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        appBar: AppBarWidget(
          isHome: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              showAlert(),
              _padding(40.0),
              PageTitle('Mein Profil',
                  'In deinem Profil kannst du auf alle wichtigen Unterlagen jederzeit zugreifen.'),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        onChanged: (input) => _email = input,
                        decoration: InputDecoration(
                          labelText: 'E-Mail Adresse*',
                          border: OutlineInputBorder(),
                        ),
                        validator: EmailValidator.validate,
                      ),
                      _padding(20.0),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        autocorrect: false,
                        onChanged: (input) => _password = input,
                        decoration: InputDecoration(
                          labelText: 'Passwort*',
                          border: OutlineInputBorder(),
                        ),
                        validator: PasswordValidator.validate,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Log In Daten vergessen?',
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xff5dc8c5),
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
              _padding(30.0),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    primary: Color(0xff5CC8C5),
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    login();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(value: false, onChanged: (bool) {}),
                  Text('eingeloggt bleiben')
                ],
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  child: Text('Account erstellen'),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    primary: Color(0xff5CC8C5),
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterationScreen()));
                  },
                ),
              ),
              _padding(10.0),
              GoogleAuthButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin(_token);
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName('/'),
                  );
                },
                style: AuthButtonStyle(
                  buttonColor: Colors.white,
                  borderColor: Colors.black.withOpacity(0.2),
                  borderRadius: 10.0,
                  width: 250.0,
                  height: 50.0,
                  iconSize: 25.0,
                  iconBackground: Colors.transparent,
                  iconType: AuthIconType.outlined,
                  buttonType: AuthButtonType.secondary,
                  padding: const EdgeInsets.all(8.0),
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              _padding(10.0),
              AppleAuthButton(
                onPressed: () {},
                darkMode: true,
                style: AuthButtonStyle(
                  buttonColor: Colors.black,
                  borderColor: Colors.black.withOpacity(0.2),
                  borderRadius: 10.0,
                  width: 250.0,
                  height: 50.0,
                  iconSize: 25.0,
                  iconType: AuthIconType.outlined,
                  buttonType: AuthButtonType.secondary,
                  padding: const EdgeInsets.all(8.0),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _appleLogin() async {
  //   final credential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     webAuthenticationOptions: WebAuthenticationOptions(
  //       clientId: 'com.aboutyou.dart_packages.sign_in_with_apple.example',
  //       redirectUri: Uri.parse(
  //         'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
  //       ),
  //     ),
  //     nonce: 'example-nonce',
  //     state: 'example-state',
  //   );

  //   print(credential);

  //   // This is the endpoint that will convert an authorization code obtained
  //   // via Sign in with Apple into a session in your system
  //   final signInWithAppleEndpoint = Uri(
  //     scheme: 'https',
  //     host: 'flutter-sign-in-with-apple-example.glitch.me',
  //     path: '/sign_in_with_apple',
  //     queryParameters: <String, String>{
  //       'code': credential.authorizationCode,
  //       if (credential.givenName != null) 'firstName': credential.givenName,
  //       if (credential.familyName != null) 'lastName': credential.familyName,
  //       'useBundleId':
  //           Platform.isAndroid || Platform.isMacOS ? 'true' : 'false',
  //       if (credential.state != null) 'state': credential.state,
  //     },
  //   );

  //   final session = await http.Client().post(
  //     signInWithAppleEndpoint,
  //   );

  //   // If we got this far, a session based on the Apple ID credential has been created in your system,
  //   // and you can now set this as the app's session
  //   print(session);
  // }
}
