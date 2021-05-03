import 'package:app/screens/profile.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _padding(double _height) {
    return SizedBox(height: _height);
  }

  Future<void> signIn() async {
    final FormState = _formKey.currentState;
    if (FormState.validate()) {
      FormState.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (conetext) => ProfileScreen()));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          _padding(40.0),
          PageTitle('Mein Profil',
              'In deinem Profil kannst du auf alle wichtigen Unterlagen jederzeit zugreifen.'),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: _formKey,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onChanged: (val) {
                    setState(() => _email = val);
                  },
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
                  onChanged: (val) {
                    setState(() => _password = val);
                  },
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
              onPressed: signIn,
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
    );
  }
}
