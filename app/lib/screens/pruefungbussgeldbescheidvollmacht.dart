//import 'dart:ui';
//import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:app/helper/helperfunctions.dart';
import 'package:open_file/open_file.dart';
import 'package:app/Api/pdfapi.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/pruefungbussgeldbescheidfinal.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class PruefungBussgeldbescheidVollmacht extends StatefulWidget {
  @override
  _PruefungBussgeldbescheidVollmachtState createState() =>
      _PruefungBussgeldbescheidVollmachtState();
}

class _PruefungBussgeldbescheidVollmachtState
    extends State<PruefungBussgeldbescheidVollmacht> {
  String myName = '';
  List<String> _fileURLs = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  firebase_storage.Reference ref;
  var file;
  final keySignaturePad = GlobalKey<SfSignaturePadState>();
  _padding([height = 20.0]) {
    return SizedBox(height: height);
  }

  @override
  void initState() {
    super.initState();
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
                // Container(
                //   width: double.infinity,
                //   height: 450,
                //   decoration: BoxDecoration(
                //     color: Colors.grey,
                //   ),
                // ),
                _padding(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text('senden'),
                      onPressed: () {
                        showAlertDialog(context,
                            "Möchten Sie das signierte Dokument wirklich senden?");
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

  showAlertDialog(BuildContext context, String dialog) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        uploadFile();
        newScreen(
          context: context,
          screen: PruefungBussgeldbescheidFinalScreen(),
        );
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
        await saveSignature();
        await OpenFile.open(file.path);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Dokument senden"),
      content: Text(dialog),
      actions: [
        previewButton,
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future saveSignature({orderNumber}) async {
    final image = await keySignaturePad.currentState.toImage();
    final imageSignature = await image.toByteData(format: ImageByteFormat.png);
    myName = await HelperFunctions().getUserNameSharedPreference();
    file = await PdfApi.generatePDF(
      myName: myName,
      orderNumber: orderNumber,
      imageSignature: imageSignature,
    );
    //await OpenFile.open(file.path);
  }

  Future uploadFile() async {
    var totalOrders = await getTotalOrderNumbers();
    var orderNumber = totalOrders.toString().padLeft(9, '0');
    await saveSignature(orderNumber: orderNumber);
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('signatures/${Path.basename(file.path)}');
    await ref.putFile(file).whenComplete(() async {
      _fileURLs.add(await ref.getDownloadURL());
    });
    _add(orderNumber);
  }

  Future<void> _add(orderNumber) async {
    Map<String, dynamic> data = <String, dynamic>{"signatureFile": _fileURLs};
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderNumber)
        .collection("Signatures")
        .add(data);
    _fileURLs.clear();
  }

  Future<void> setTotalOrderNumbers(noOfOrders) async {
    Map<String, dynamic> data = <String, dynamic>{"totalOrders": noOfOrders};
    await FirebaseFirestore.instance
        .collection("TotalOrders")
        .doc('All Order Numbers')
        .set(data);
  }

  Future<int> getTotalOrderNumbers() async {
    int totalOrders = 0;
    var userQuery = await FirebaseFirestore.instance
        .collection("TotalOrders")
        .doc('All Order Numbers')
        .get();
    if (userQuery.exists) {
      totalOrders = userQuery.get('totalOrders');
      totalOrders++;
      setTotalOrderNumbers(totalOrders);
      return totalOrders;
    } else {
      setTotalOrderNumbers(1);
      return 1;
    }
  }
}
