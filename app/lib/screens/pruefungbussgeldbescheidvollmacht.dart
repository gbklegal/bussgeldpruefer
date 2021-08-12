import 'dart:ui';
import 'package:app/constants.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/services/database.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:app/helper/helperfunctions.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                        print(keySignaturePad.currentState);
                        isConnection =
                            await ConnectionStatus().checkConnectionStatus();
                        isConnection
                            ? showAlertDialog(context,
                                "Möchten Sie das signierte Dokument wirklich senden?")
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

  showAlertDialog(BuildContext context, String dialog) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.pop(context);
        setState(() {
          uploading = true;
        });
        await DatabaseMethods().uploadFile(file).whenComplete(() {
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
