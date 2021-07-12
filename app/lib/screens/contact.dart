import 'dart:convert';
import 'package:app/services/connectivity.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:app/functions/isvalidemail.dart';
import 'package:app/functions/isvalidphonenumber.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contactfeedback.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../global.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

Future sendForm({
  String firstname,
  String lastname,
  String email,
  String phone,
  String message,
  TypeOfContact contactType,
}) async {
  final Uri apiUrl =
      Uri.parse('https://dev02.gbk-rae.de/bgp/app/contactform.php');
  final response = await http.post(
    apiUrl,
    body: {
      'firstname': firstname,
      'lastname': lastname,
      'email': email.isEmpty ? '/' : email,
      'phone': phone.isEmpty ? '/' : phone,
      'message': message,
      'contactType': contactType == TypeOfContact.email ? 'E-Mail' : 'Telefon',
      'source': 'App 1.0.0+1',
    },
  );
  final statusCode = response.statusCode;

  if (statusCode != 200) {
    throw new Exception(
        // ignore: todo
        'Error while fetching data'); // TODO: change this message text
  }

  final data = json.decode(response.body);
  // ignore: todo
  // TODO: return feedback
  print('sendmail: ' + data['sendmail'].toString());
}

enum TypeOfContact { phone, email }

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  TypeOfContact _contactType;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  _padding() {
    return SizedBox(height: 20.0);
  }

  _simpleText(text) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }

  _callPhoneNumber(phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            PageTitle('Kontaktformular', 'Du hast Fragen?'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _firstnameController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Vorname',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value.isEmpty
                              ? 'Bitte gebe einen Vornamen ein'
                              : null,
                        ),
                        _padding(),
                        TextFormField(
                          controller: _lastnameController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Nachname',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value.isEmpty
                              ? 'Bitte gebe einen Nachnamen ein'
                              : null,
                        ),
                        _padding(),
                        TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'E-Mail',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (_contactType != TypeOfContact.email ||
                                  _contactType == null) return null;
                              if (value.isEmpty)
                                return 'Bitte gebe eine E-Mail Adresse ein';
                              if (!isValidEmail(value))
                                return 'Bitte gebe eine richtige E-Mail Adresse ein';
                              return null;
                            }),
                        _padding(),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Telefonnummer',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (_contactType != TypeOfContact.phone ||
                                _contactType == null) return null;
                            if (value.isEmpty)
                              return 'Bitte gebe eine Telefonnummer ein';
                            if (!isValidPhoneNumber(value))
                              return 'Bitte gebe eine richtige Telefonnummer ein';
                            return null;
                          },
                        ),
                        _padding(),
                        TextFormField(
                          controller: _messageController,
                          maxLines: 5,
                          maxLength: 120,
                          decoration: InputDecoration(
                            hintText: 'Nachricht',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value.isEmpty
                              ? 'Bitte gebe eine Nachricht ein'
                              : null,
                        ),
                        _padding(),
                        ListTile(
                          title: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Ich möchte '),
                                TextSpan(
                                    text: 'telefonisch',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ' kontaktiert werden.'),
                              ],
                            ),
                          ),
                          leading: Radio(
                            value: TypeOfContact.phone,
                            groupValue: _contactType,
                            onChanged: (TypeOfContact value) {
                              setState(() => _contactType = value);
                            },
                          ),
                        ),
                        ListTile(
                          title: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Ich möchte '),
                                TextSpan(
                                    text: 'per E-Mail',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ' kontaktiert werden.'),
                              ],
                            ),
                          ),
                          leading: Radio(
                            value: TypeOfContact.email,
                            groupValue: _contactType,
                            onChanged: (TypeOfContact value) {
                              setState(() => _contactType = value);
                            },
                          ),
                        ),
                        _padding(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              isConnection = await ConnectionStatus()
                                  .checkConnectionStatus();
                              if (isConnection) {
                                if (_formKey.currentState.validate()) {
                                  // sendmail
                                  sendForm(
                                    firstname: _firstnameController.text,
                                    lastname: _lastnameController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                    message: _messageController.text,
                                    contactType: _contactType,
                                  );
                                  // clear/reset contact form
                                  _formKey.currentState.reset();
                                  setState(() => _contactType = null);
                                  // open next screen, maybe change this to a simple alert
                                  newScreen(
                                    context: context,
                                    screen: ContactFeedbackScreen(),
                                  );
                                } else {
                                  print('Formular ist nicht gültig');
                                }
                              } else {
                                ConnectionDialog().showAlertDialog(context,
                                    noInternetTitle, notConnectedInternet);
                              }
                            },
                            child: Text('senden'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _padding(),
                  _padding(),
                  _simpleText(
                      'Du möchtest lieber telefonisch unterstüzt werden?\n\nDu kannst gerne Konakt mit einem Berater aufnehmen:'),
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () => _callPhoneNumber('+49911893103444'),
                    tooltip: 'Telefon',
                  ),
                  _simpleText('Sprechzeiten\nMo. - Fr. 10 - 18 Uhr'),
                  _padding(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
