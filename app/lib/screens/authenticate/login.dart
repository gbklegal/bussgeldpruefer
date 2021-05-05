import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

import 'package:flutter/material.dart';

import '../profilepage/profile.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  _padding(double _height) {
    return SizedBox(height: _height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
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
                      onSaved: (input) => _email = input,
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
                      onSaved: (input) => _password = input,
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
                onPressed: login,
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
