import 'package:flutter/material.dart';

class DummyScreen extends StatefulWidget {
  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  final _formKey = GlobalKey<FormState>();

  _padding() {
    return SizedBox(height: 20.0);
  }

  _image(name) {
    return Image.asset(
      name,
      width: 184,
    );
  }

  // Future

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
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Text',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Bitte gebe einen Text ein' : null,
                      ),
                      _padding(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            child: Text('senden'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // TODO: make http request
                              } else {
                                print('Formular ungültig');
                              }
                            }),
                      ),
                    ],
                  ),
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
