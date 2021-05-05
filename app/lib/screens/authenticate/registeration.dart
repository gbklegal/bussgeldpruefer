import 'package:app/screens/authenticate/login.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterationScreen extends StatefulWidget {
  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;
  Future<void> register() async {
    UserCredential user = (await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password));
  }

  _padding(double _height) {
    return SizedBox(height: _height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _padding(40.0),
            PageTitle('Mein Profil'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Vorname',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value.isEmpty
                          ? 'Bitte geben Sie den Vornamen ein'
                          : null,
                    ),
                    _padding(20.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Nachname',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value.isEmpty
                          ? 'Bitte geben Sie den Nachnamen ein'
                          : null,
                    ),
                    _padding(20.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onChanged: (input) => _email = input,
                      decoration: InputDecoration(
                        labelText: 'E-Mail Adresse',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value.isEmpty
                          ? 'Bitte geben Sie die gültige E-Mail-Adresse ein'
                          : null,
                    ),
                    _padding(20.0),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      autocorrect: false,
                      onChanged: (input) => _password = input,
                      decoration: InputDecoration(
                        labelText: 'Passwort',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value.isEmpty
                          ? 'Bitte geben Sie das Passwort ein (mindestens 6 Zeichen)'
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
                    '*Pflichtfelder',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: -0.3,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
            _padding(30.0),
            SizedBox(
              width: 200.0,
              height: 50.0,
              child: ElevatedButton(
                child: Text('Registrieren'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  primary: Color(0xff5CC8C5),
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    register();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
