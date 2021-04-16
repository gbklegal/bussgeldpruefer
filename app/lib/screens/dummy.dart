import 'package:flutter/material.dart';

enum Violation {
  alcohol,
  distance,
  parking,
  phone,
  redlight,
  speed,
}

class DummyScreen extends StatefulWidget {
  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  Violation _violation = Violation.distance;

  _paddingWidth() {
    return SizedBox(width: 20.0);
  }

  // _paddingHeight() {
  //   return SizedBox(height: 20.0);
  // }

  _image(name) {
    return Image.asset(
      name,
      width: 184,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menü Header'),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Row>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _image('assets/images/speed.jpg'),
                        Radio<Violation>(
                          value: Violation.speed,
                          groupValue: _violation,
                          onChanged: (Violation value) {
                            setState(() => _violation = value);
                          },
                        ),
                      ],
                    ),
                    _paddingWidth(),
                    Column(
                      children: <Widget>[
                        _image('assets/images/redlight.jpg'),
                        Radio<Violation>(
                          value: Violation.redlight,
                          groupValue: _violation,
                          onChanged: (Violation value) {
                            setState(() => _violation = value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _image('assets/images/distance.jpg'),
                        Radio<Violation>(
                          value: Violation.distance,
                          groupValue: _violation,
                          onChanged: (Violation value) {
                            setState(() => _violation = value);
                          },
                        ),
                      ],
                    ),
                    _paddingWidth(),
                    Column(
                      children: <Widget>[
                        _image('assets/images/alcohol.jpg'),
                        Radio<Violation>(
                          value: Violation.alcohol,
                          groupValue: _violation,
                          onChanged: (Violation value) {
                            setState(() => _violation = value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _image('assets/images/phone.jpg'),
                        Radio<Violation>(
                          value: Violation.phone,
                          groupValue: _violation,
                          onChanged: (Violation value) {
                            setState(() => _violation = value);
                          },
                        ),
                      ],
                    ),
                    _paddingWidth(),
                    Column(
                      children: <Widget>[
                        _image('assets/images/parking.jpg'),
                        Radio<Violation>(
                          value: Violation.parking,
                          groupValue: _violation,
                          onChanged: (Violation value) {
                            setState(() => _violation = value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
