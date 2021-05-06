import 'package:app/screens/authenticate/registeration.dart';
import 'package:app/screens/profile/profiledata.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
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

  String _email, _password;
  String error = '';

  Future<bool> login() async {
    final user = (await _auth.signInWithEmailAndPassword(
            email: _email.trim(), password: _password))
        .user;
    if (user.emailVerified) {
      return true;
    }
    return false;
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
                        validator: (value) => value.isEmpty
                            ? 'Bitte geben Sie eine E-mail-Adresse ein'
                            : null,
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
                        validator: (value) => value.length < 6
                            ? 'Ihr Passwort muss mindestens 6 Zeichen lang sein'
                            : null,
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
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Future<bool> check = login();
                      if (check == true) {
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName('/'),
                        );
                      }
                    }
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
