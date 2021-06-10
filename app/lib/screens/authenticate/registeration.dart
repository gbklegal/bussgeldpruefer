import 'package:app/helper/helperfunctions.dart';
import 'package:app/screens/authenticate/login.dart';
import 'package:app/services/database.dart';
import 'package:app/services/validators.dart';
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
  DatabaseMethods databaseMethods = new DatabaseMethods();

  String _email, _password, _error, _firstName, _lastName;

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

  void register() async {
    if (validate()) {
      try {
        // ignore: unused_local_variable
        UserCredential user = (await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password));

        Map<String, String> userInfoMap = {
          "name": _firstName + ' ' + _lastName,
          "email": _email
        };
        HelperFunctions().saveUserEmailSharedPreference(_email);
        HelperFunctions()
            .saveUserNameSharedPreference(_firstName + ' ' + _lastName);

        HelperFunctions().saveUserLoggedInSharedPreference(true);
        databaseMethods.addUserInfo(userInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
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
    return Scaffold(
      appBar: AppBarWidget(
        isHome: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            showAlert(),
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
                      onChanged: (input) => _firstName = input.trim(),
                      decoration: InputDecoration(
                        labelText: 'Vorname',
                        border: OutlineInputBorder(),
                      ),
                      validator: VorNameValidator.validate,
                    ),
                    _padding(20.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      onChanged: (input) => _lastName = input.trim(),
                      decoration: InputDecoration(
                        labelText: 'Nachname',
                        border: OutlineInputBorder(),
                      ),
                      validator: NachNameValidator.validate,
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
                      validator: EmailValidator.validate,
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
                onPressed: register,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
