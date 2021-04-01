import 'package:app/functions/newscreen.dart';
import 'package:app/screens/pruefungbussgeldbescheidfileupload.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class PruefungBussgeldbescheidScreen extends StatefulWidget {
  @override
  _PruefungBussgeldbescheidScreenState createState() =>
      _PruefungBussgeldbescheidScreenState();
}

class _PruefungBussgeldbescheidScreenState
    extends State<PruefungBussgeldbescheidScreen> {
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

  double _demoPadding = 10.0;

  _demoBlockPadding(direction) {
    if (direction == 'width') {
      return SizedBox(width: _demoPadding);
    }
    return SizedBox(height: _demoPadding);
  }

  _demoBlock() {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.5) - 25,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.grey.shade300,
      ),
    );
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
                    _demoBlockPadding('height'),
                    Row(
                      children: <Widget>[
                        _demoBlock(),
                        _demoBlockPadding('width'),
                        _demoBlock()
                      ],
                    ),
                    _demoBlockPadding('height'),
                    Row(
                      children: <Widget>[
                        _demoBlock(),
                        _demoBlockPadding('width'),
                        _demoBlock()
                      ],
                    ),
                    _demoBlockPadding('height'),
                    Row(
                      children: <Widget>[
                        _demoBlock(),
                        _demoBlockPadding('width'),
                        _demoBlock()
                      ],
                    ),
                  ],
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
                            onPressed: () => print('restart'),
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
