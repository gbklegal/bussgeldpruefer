//import 'dart:ui';
//import 'dart:async';
import 'dart:ui';

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
  final keySignaturePad = GlobalKey<SfSignaturePadState>();
  _padding([height = 20.0]) {
    return SizedBox(height: height);
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
                    onPressed: () => newScreen(
                      context: context,
                      screen: PruefungBussgeldbescheidFinalScreen(),
                    ),
                  ),
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

    final file = await PdfApi.generatePDF(
      imageSignature: imageSignature,
    );
    await OpenFile.open(file.path);
  }
}
