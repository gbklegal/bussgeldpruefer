import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class ForgotCredentialsScreen extends StatefulWidget {
  @override
  _ForgotCredentialsScreenState createState() =>
      _ForgotCredentialsScreenState();
}

class _ForgotCredentialsScreenState extends State<ForgotCredentialsScreen> {
  _padding(double _height) {
    return SizedBox(height: _height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            _padding(40.0),
            PageTitle('Mein Profil', 'Du hast deine Login Daten vergessen?'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'E-Mail Adresse',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value.isEmpty
                        ? 'Bitte geben Sie die gültige E-Mail-Adresse ein'
                        : null,
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
