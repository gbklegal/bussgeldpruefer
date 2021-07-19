import 'package:app/services/validators.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotCredentialsScreen extends StatefulWidget {
  @override
  _ForgotCredentialsScreenState createState() =>
      _ForgotCredentialsScreenState();
}

class _ForgotCredentialsScreenState extends State<ForgotCredentialsScreen> {
  String _email, _error;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _padding(double _height) {
    return SizedBox(height: _height);
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

  _resetPassword() async {
    if (validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        if (_error == null) {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Password reset email sent to " + _email,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2);
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            showAlert(),
            _padding(40.0),
            PageTitle('Mein Profil', 'Du hast deine Login Daten vergessen?'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onChanged: (input) => _email = input,
                      decoration: InputDecoration(
                        labelText: 'E-Mail Adresse',
                        border: OutlineInputBorder(),
                      ),
                      validator: EmailValidator.validate,
                      // (value) => value.isEmpty
                      //     ? 'Bitte geben Sie die gültige E-Mail-Adresse ein'
                      //     : null,
                    ),
                    _padding(30.0),
                    SizedBox(
                      width: 250.0,
                      child: ElevatedButton(
                        child: Text('Neues Passwort beantragen'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          primary: Color(0xff5CC8C5),
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          _resetPassword();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
