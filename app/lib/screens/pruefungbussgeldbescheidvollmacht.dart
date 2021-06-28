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
                        uploadFile();
                        newScreen(
                          context: context,
                          screen: PruefungBussgeldbescheidFinalScreen(),
                        );
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
                            onPressed: () {
                              saveSignature();
                            },
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

  Future saveSignature() async {
    final image = await keySignaturePad.currentState.toImage();
    final imageSignature = await image.toByteData(format: ImageByteFormat.png);
    myName = await HelperFunctions().getUserNameSharedPreference();
    file = await PdfApi.generatePDF(
      myName: myName,
      imageSignature: imageSignature,
    );
    await OpenFile.open(file.path);
  }

  Future uploadFile() async {
    // int i = 1;
    // for (var img in _image) {
    //   setState(() {
    //     val = i / _image.length;
    //   });
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('signatures/${Path.basename(file.path)}');
    await ref.putFile(file).whenComplete(() async {
      _fileURLs.add(await ref.getDownloadURL());
      //i++;
    });

    _add();
  }

  Future<void> _add() async {
    String orderNumberFormat = '000000000';
    var totalOrders = await getTotalOrderNumbers();

    print("productCount" +
        totalOrders.toString()); // Count of Documents in Collection
    int orderNumber = int.parse(orderNumberFormat) + totalOrders;
    Map<String, dynamic> data = <String, dynamic>{"signatureFile": _fileURLs};
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderNumber.toString())
        .collection("Signatures")
        .add(data)
        .whenComplete(() {
      print("Document Added");
    });
    // await FirebaseFirestore.instance
    //     .collection("TotalOrders")
    //     .add(data)
    //     .whenComplete(() {
    //   print("Document Added");
    // });
    setTotalOrderNumbers(totalOrders + 1);
    _fileURLs.clear();
  }

  Future<int> setTotalOrderNumbers(noOfOrders) async {
    Map<String, dynamic> data = <String, dynamic>{"totalOrders": noOfOrders};
    await FirebaseFirestore.instance
        .collection("TotalOrders")
        .doc('All Order Numbers')
        .set(data)
        .whenComplete(() {
      print("Document Added");
    });
  }

  Future<int> getTotalOrderNumbers() async {
    int totalOrders = 0;
    var userQuery = await FirebaseFirestore.instance
        .collection("TotalOrders")
        .doc('All Order Numbers')
        .get()
        .then((value) {
      print("ABC:" + value.get('totalOrders').toString());
      totalOrders = value.get('totalOrders');
    });
    return totalOrders;
  }
}
