import 'package:app/functions/newscreen.dart';
import 'package:app/screens/pruefungbussgeldbescheidvollmacht.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';

class PruefungBussgeldbescheidFileUploadScreen extends StatefulWidget {
  @override
  _PruefungBussgeldbescheidFileUploadScreenState createState() =>
      _PruefungBussgeldbescheidFileUploadScreenState();
}

class _PruefungBussgeldbescheidFileUploadScreenState
    extends State<PruefungBussgeldbescheidFileUploadScreen> {
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

  String documentName = 'Anhörungsbogen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ListView(
        children: [
          PageTitle('Prüfung Bußgeldbescheid'),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Lade Deine Unterlagen hoch',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    'Mit der Kamerafunktion kannst du ganz einfach Fotos von deinen Unterlagen machen oder wähle ein Foto aus deinem Album.'),
                _padding(),
                _title('1. Wähle ein Dokument aus, dass du hochladen willst'),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: documentName,
                    icon: const Icon(Icons.expand_more),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (String newValue) {
                      setState(() => documentName = newValue);
                    },
                    items: <String>[
                      'Anhörungsbogen',
                      'Bußgeldbescheid',
                      'Strafbefehl',
                      'Zeugenanhörungsbogen',
                      'Verwarnung',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                _padding(),
                _title('2. Mache ein Foto von deinem Dokument'),
                Text('Vergiss nicht die Vorder- und Rückseite'),
                _padding(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.photo_camera_outlined),
                        onPressed: () => print('Take photo with camera.'),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.photo_library_outlined),
                        onPressed: () => print('Get photo from library.'),
                      ),
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
                              screen: PruefungBussgeldbescheidVollmacht(),
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
