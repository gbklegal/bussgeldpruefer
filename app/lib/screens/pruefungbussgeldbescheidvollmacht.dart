import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:app/constants.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/services/database.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:app/helper/helperfunctions.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:app/Api/pdfapi.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/pruefungbussgeldbescheidfinal.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../global.dart';

class PruefungBussgeldbescheidVollmacht extends StatefulWidget {
  final String violatioName;
  PruefungBussgeldbescheidVollmacht(this.violatioName);
  @override
  _PruefungBussgeldbescheidVollmachtState createState() =>
      _PruefungBussgeldbescheidVollmachtState();
}

class _PruefungBussgeldbescheidVollmachtState
    extends State<PruefungBussgeldbescheidVollmacht> {
  bool uploading = false;
  String myName = '';
  var file;
  final keySignaturePad = GlobalKey<SfSignaturePadState>();
  String firstName, lastName, email;
  _padding([height = 20.0]) {
    return SizedBox(height: height);
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    firstName = await HelperFunctions().getFirstNameSharedPreference();
    lastName = await HelperFunctions().getLastNameSharedPreference();
    email = await HelperFunctions().getUserEmailSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ListView(
        children: <Widget>[
          PageTitle('Prüfung Bußgeldbescheid'),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Unterscheibe die Vollmacht',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    'Unterschreibe diese Vollmacht mit deiner Unterschrift - ganz einfach digital'),
                _padding(),
                Text('DocuSign'),
                _padding(),
                SfSignaturePad(
                  key: keySignaturePad,
                  backgroundColor: Colors.grey[200],
                ),
                _padding(),
                uploading
                    ? Center(
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Text(
                              'Hochladen...',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          _padding(10.0),
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          ),
                        ],
                      ))
                    : Container(),
                _padding(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text('senden'),
                      onPressed: () async {
                        await saveSignature();
                        isConnection =
                            await ConnectionStatus().checkConnectionStatus();
                        isConnection
                            ? showAlertDialog(
                                context,
                                "Möchten Sie das signierte Dokument wirklich senden?",
                                widget.violatioName)
                            : ConnectionDialog().showAlertDialog(context,
                                uploadDialogTitle, notConnectedInternet);
                      }),
                ),
                _padding(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text('zurück'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              setState(() {
                                keySignaturePad.currentState.clear();
                              });
                            },
                          ),
                          Text('neu starten'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.save_outlined),
                            onPressed: () {},
                          ),
                          Text('speichern'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String dialog, String violationName) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.pop(context);
        setState(() {
          uploading = true;
        });
        await DatabaseMethods().uploadFile(file, violationName).then((value) {
          DateTime dateTime = DateTime.now();
          sendForm(
              firstName: firstName,
              lastName: lastName,
              email: email,
              dateTime: dateTime.toString(),
              violationName: violationName,
              orderId: value);
        }).whenComplete(() {
          setState(() {
            uploading = false;
          });
          newScreen(
            context: context,
            screen: PruefungBussgeldbescheidFinalScreen(),
          );
        });
      },
    );
    Widget cancelButton = ElevatedButton(
      child: Text("Stornieren"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget previewButton = ElevatedButton(
      child: Text("Dokumentvorschau"),
      onPressed: () async {
        await OpenFile.open(file.path);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Dokument senden"),
      content: Text(dialog),
      actions: [
        previewButton,
        cancelButton,
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future sendForm({
    String firstName,
    String lastName,
    String email,
    String dateTime,
    String violationName,
    String orderId,
  }) async {
    final Uri apiUrl =
        Uri.parse('https://xn--bussgeldprfer-5ob.com/bgp/mail/order/mail.php');
    final response = await http.post(
      apiUrl,
      body: {
        'key':
            'nKP6Wu7m315BOkxSW0NE1r1KDH7RibWD601xdvrsjH1fDwqQdJIzUhbmpIOmCR1q',
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'datetime': dateTime,
        'violation': violationName,
        'orderId': orderId,
        'medium': 'app',
      },
    );
    print("Email Send Form : " + email);
    final statusCode = response.statusCode;

    if (statusCode != 200) {
      throw new Exception(
          // ignore: todo
          'Error while fetching data'); // TODO: change this message text
    }
  }

  Future saveSignature({orderNumber}) async {
    var totalOrders = await DatabaseMethods().getTotalOrderNumbers();
    var orderNumber = "2021" + totalOrders.toString().padLeft(4, '0');
    final image = await keySignaturePad.currentState.toImage();
    final imageSignature = await image.toByteData(format: ImageByteFormat.png);
    myName = await HelperFunctions().getUserNameSharedPreference();
    file = await PdfApi.generatePDF(
      myName: myName,
      orderNumber: orderNumber,
      imageSignature: imageSignature,
    );
  }
}
