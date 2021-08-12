import 'package:app/constants.dart';
import 'package:app/helper/helperfunctions.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/services/database.dart';
import 'package:app/services/validators.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../global.dart';

class RegisterationScreen extends StatefulWidget {
  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String _email, _password, _error, _firstName, _lastName, _token;

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

  void register() async {
    if (validate()) {
      try {
        var userInfoMap = {
          "name": {"first": _firstName, "last": _lastName},
          "email": _email,
          "FCMtoken": _token,
          "orderId": null
        };
        HelperFunctions().saveValues(_firstName, _lastName, _email);
        UserCredential user = (await _auth
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .whenComplete(() {
          DatabaseMethods().addUserInfo(userInfoMap);
          Fluttertoast.showToast(
            msg: "Logged in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }));
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
                  primary: kSecondaryColor,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  isConnection =
                      await ConnectionStatus().checkConnectionStatus();
                  isConnection
                      ? register()
                      : ConnectionDialog().showAlertDialog(
                          context, registerDialogTitle, notConnectedInternet);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
