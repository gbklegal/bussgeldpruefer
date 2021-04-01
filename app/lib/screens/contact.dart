import 'package:app/functions/newscreen.dart';
import 'package:app/screens/contactfeedback.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

import 'package:app/widgets/appbar.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

enum TypeOfContact { phone, email }

class _ContactScreenState extends State<ContactScreen> {
  TypeOfContact _contactType; // = TypeOfContact.lafayette;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Vorname',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _padding(),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Nachname',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _padding(),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'E-Mail',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _padding(),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Telefonnummer',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _padding(),
                        TextFormField(
                          maxLines: 5,
                          maxLength: 120,
                          decoration: InputDecoration(
                            hintText: 'Nachricht',
                            border: OutlineInputBorder(),
                          ),
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
                              setState(() {
                                _contactType = value;
                              });
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
                              setState(() {
                                _contactType = value;
                              });
                            },
                          ),
                        ),
                        _padding(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => newScreen(
                              context: context,
                              screen: ContactFeedbackScreen(),
                            ),
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
