import 'package:app/functions/newscreen.dart';
import 'package:app/screens/pruefungbussgeldbescheidfileupload.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class PruefungBussgeldbescheidScreen extends StatefulWidget {
  @override
  _PruefungBussgeldbescheidScreenState createState() =>
      _PruefungBussgeldbescheidScreenState();
}

class _PruefungBussgeldbescheidScreenState
    extends State<PruefungBussgeldbescheidScreen> {
  List<String> violationImageNames = [
    'speed',
    'redlight',
    'distance',
    'alcohol',
    'phone',
    'parking'
  ];
  List<String> violationNames = [
    'Geschwindig\u2011\nkeit',
    'Rote Ampel',
    'Abstand',
    'Alkohol',
    'Telefon',
    'Falschparken'
  ];
  int selectedViolationIndex;
  _title(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22.0,
      ),
    );
  }

  _padding([height = 20.0]) {
    return SizedBox(height: height);
  }

  //double _demoPadding = 10.0;

  // _demoBlockPadding(direction) {
  //   if (direction == 'width') {
  //     return SizedBox(width: _demoPadding);
  //   }
  //   return SizedBox(height: _demoPadding);
  // }

  // _demoBlock() {
  //   return Container(
  //     width: (MediaQuery.of(context).size.width * 0.5) - 25,
  //     height: 100.0,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //       color: Colors.grey.shade300,
  //     ),
  //   );
  // }

  void changeViolationIndex(int index) {
    setState(() => selectedViolationIndex = index);
  }

  Widget customImageRadio(String image, String name, int index) {
    return GestureDetector(
      onTap: () => changeViolationIndex(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: (index == selectedViolationIndex)
                ? Colors.blue
                : Colors.transparent,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Image.asset('assets/images/$image.jpg'),
            BorderedText(
              strokeColor: Colors.black,
              strokeWidth: 3,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _resetQuickCheck() {
    setState(() {
      selectedViolationIndex = null;
    });
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
                _title('Wähle den Verstoß aus'),
                _padding(10.0),
                Column(
                  children: <Widget>[
                    _padding(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: customImageRadio(
                              violationImageNames[0], violationNames[0], 0),
                        ),
                        Expanded(
                          child: customImageRadio(
                              violationImageNames[1], violationNames[1], 1),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: customImageRadio(
                              violationImageNames[2], violationNames[2], 2),
                        ),
                        Expanded(
                          child: customImageRadio(
                              violationImageNames[3], violationNames[3], 3),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: customImageRadio(
                              violationImageNames[4], violationNames[4], 4),
                        ),
                        Expanded(
                          child: customImageRadio(
                              violationImageNames[5], violationNames[5], 5),
                        ),
                      ],
                    ),
                  ],
                ),
                // Column(
                //   children: <Widget>[
                //     _demoBlockPadding('height'),
                //     Row(
                //       children: <Widget>[
                //         _demoBlock(),
                //         _demoBlockPadding('width'),
                //         _demoBlock()
                //       ],
                //     ),
                //     _demoBlockPadding('height'),
                //     Row(
                //       children: <Widget>[
                //         _demoBlock(),
                //         _demoBlockPadding('width'),
                //         _demoBlock()
                //       ],
                //     ),
                //     _demoBlockPadding('height'),
                //     Row(
                //       children: <Widget>[
                //         _demoBlock(),
                //         _demoBlockPadding('width'),
                //         _demoBlock()
                //       ],
                //     ),
                //   ],
                // ),

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
                            onPressed: () => _resetQuickCheck(),
                          ),
                          Text('neu starten'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () => newScreen(
                              context: context,
                              screen:
                                  PruefungBussgeldbescheidFileUploadScreen(),
                            ),
                          ),
                          Text('weiter'),
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
}
