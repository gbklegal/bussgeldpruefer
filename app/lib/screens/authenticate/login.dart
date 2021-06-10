import 'package:app/helper/helperfunctions.dart';
import 'package:app/screens/authenticate/registeration.dart';
import 'package:app/services/database.dart';
import 'package:app/services/validators.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  String _email, _password, _error;
  String error = '';

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
        String name;
        name = await HelperFunctions().getUserNameSharedPreference();
        print(name);
        HelperFunctions()
            .saveUserEmailSharedPreference(userInfoSnapshot.docs[0]['email']);
        HelperFunctions().saveUserLoggedInSharedPreference(true);
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
            ],
          ),
        ),
      ),
    );
  }
}
