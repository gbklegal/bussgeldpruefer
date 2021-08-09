import 'dart:io';
import 'package:app/services/connectivity.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/functions/newscreen.dart';
import 'package:app/screens/pruefungbussgeldbescheidvollmacht.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../global.dart';

class PruefungBussgeldbescheidFileUploadScreen extends StatefulWidget {
  @override
  _PruefungBussgeldbescheidFileUploadScreenState createState() =>
      _PruefungBussgeldbescheidFileUploadScreenState();
}

class _PruefungBussgeldbescheidFileUploadScreenState
    extends State<PruefungBussgeldbescheidFileUploadScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool uploading = false;
  double val = 0;
  firebase_storage.Reference ref;
  List<File> _image = [];
  int _imageId;
  List<String> _fileURLs = [];
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                      color: kPrimaryColor,
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
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 130,
                  ),
                  child: _buildGridView(),
                ),
                _padding(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.photo_camera_outlined),
                        onPressed: () => chooseImage(ImageSource.camera),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.photo_library_outlined),
                        onPressed: () => chooseImage(ImageSource.gallery),
                      ),
                    ),
                  ],
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
                            value: val,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          ),
                          _padding(10.0),
                          Container(
                            child: Text(
                              (val * _image.length).toInt().toString() +
                                  ' von ' +
                                  _image.length.toString() +
                                  ' Dokumenten hochgeladen',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ))
                    : Container(),
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
                                clearAll();
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
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () async {
                              isConnection = await ConnectionStatus()
                                  .checkConnectionStatus();
                              if (isConnection && _image.length != 0) {
                                setState(() {
                                  uploading = true;
                                });
                                uploadFile().whenComplete(() {
                                  setState(() {
                                    uploading = false;
                                  });
                                  if (_image.length == 0) {
                                    showAlertDialog(context, 0,
                                        "Es ist kein Dokument ausgewählt. Durch Klicken auf OK gelangen Sie zum nächsten Bildschirm.");
                                  } else {
                                    showAlertDialog(context, 1,
                                        "Alle Dokumenten wurden erfolgreich hochgeladen");
                                  }
                                });
                              } else if (_image.length == 0) {
                                setState(() {
                                  uploading = true;
                                });
                                uploadFile().whenComplete(() {
                                  setState(() {
                                    uploading = false;
                                  });
                                  if (_image.length == 0) {
                                    showAlertDialog(context, 0,
                                        "Es ist kein Dokument ausgewählt. Durch Klicken auf OK gelangen Sie zum nächsten Bildschirm.");
                                  } else {
                                    showAlertDialog(context, 1,
                                        "Alle Dokumenten wurden erfolgreich hochgeladen");
                                  }
                                });
                              } else {
                                ConnectionDialog().showAlertDialog(context,
                                    uploadDialogTitle, notConnectedInternet);
                              }
                            },
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

  showAlertDialog(BuildContext context, int status, String dialog) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          clearAll();
        });
        newScreen(
          context: context,
          screen: PruefungBussgeldbescheidVollmacht(),
        );
      },
    );
    Widget cancelButton = ElevatedButton(
      child: Text("Stornieren"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert;
    if (status == 1) {
      alert = AlertDialog(
        title: Text("Dokument hochladen"),
        content: Text(dialog),
        actions: [
          okButton,
        ],
      );
    } else {
      alert = AlertDialog(
        title: Text("Dokument hochladen"),
        content: Text(dialog),
        actions: [
          cancelButton,
          okButton,
        ],
      );
    }

    // set up the AlertDialog
    // AlertDialog alert = AlertDialog(
    //   title: Text("Dokument hochladen"),
    //   content: Text(dialog),
    //   actions: [
    //     okButton,
    //   ],
    // );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  chooseImage(ImageSource _source) async {
    final pickedFile = await picker.getImage(source: _source);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future uploadFile() async {
    int i = 1;
    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        _fileURLs.add(await ref.getDownloadURL());
        i++;
      });
    }
    print(_fileURLs);
    if (_image.length != 0 && _fileURLs.length != 0) _add();
  }

  Future<void> _add() async {
    final uid = (_firebaseAuth.currentUser.uid);
    Map<String, dynamic> data = <String, dynamic>{
      "name": documentName,
      "fileURLs": FieldValue.arrayUnion(_fileURLs)
    };
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(uid)
        .collection("Files")
        .add(data)
        .whenComplete(() {
      print("Document Added");
    });
    clearAll();
  }

  clearAll() {
    documentName = 'Anhörungsbogen';
    _fileURLs.clear();
    _image.clear();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Widget _buildGridView() {
    return _image.length == 0
        ? const Text(
            'Kein Dokument ausgewählt',
            textAlign: TextAlign.center,
          )
        : GridView.builder(
            key: _scaffoldKey,
            itemCount: _image.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(3),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 13.0, right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(
                          _image[index],
                          fit: BoxFit.fill,
                          width: 100.0,
                          height: 130.0,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _imageId = index;
                            _image.removeAt(_imageId);
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.grey[50],
                            child: CircleAvatar(
                                radius: 12.0,
                                backgroundColor: kPrimaryColor,
                                child: Icon(Icons.close, color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
