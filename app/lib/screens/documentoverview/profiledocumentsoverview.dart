import 'dart:io';
import 'package:app/global.dart';
import 'package:app/screens/documentoverview/fullscreenimage.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class ProfileDocumentsOverviewScreen extends StatefulWidget {
  @override
  _ProfileDocumentsOverviewScreenState createState() =>
      _ProfileDocumentsOverviewScreenState();
}

class _ProfileDocumentsOverviewScreenState
    extends State<ProfileDocumentsOverviewScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool uploading = false;
  double val = 0;
  firebase_storage.Reference ref;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _id;
  List<File> _image = [];
  final picker = ImagePicker();
  List<String> _fileURLs = [];
  List<String> _getImages = [];
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  clearAll() {
    _fileURLs.clear();
    _image.clear();
  }

  _title(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22.0,
      ),
    );
  }

  _padding([width = 0.0, height = 20.0]) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  _headerTitle() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),
          child: Icon(
            Icons.cloud_upload_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        _padding(10.0),
        Text(
          'Dokumentenübersicht',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  String documentName = 'Anhörungsbogen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageTitle('Prüfung Bußgeldbescheid'),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _headerTitle(),
                  _padding(),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 120,
                    ),
                    child: _buildGridViewForOverview(),
                  ),
                  _padding(),
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
                  //showImage(),
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
                          //print('Take photo with camera.'),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.photo_library_outlined),
                          onPressed: () => chooseImage(ImageSource.gallery),
                          //print('Get photo from library.'),
                        ),
                      ),
                    ],
                  ),
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
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('senden'),
                      onPressed: () async {
                        isConnection =
                            await ConnectionStatus().checkConnectionStatus();
                        if (isConnection && _image.length != 0) {
                          setState(() {
                            uploading = true;
                          });
                          uploadFile().whenComplete(() {
                            setState(() {
                              uploading = false;
                            });
                            if (_image.length == 0) {
                              showAlertDialog(
                                  context, "Es ist kein Dokument ausgewählt.");
                            } else {
                              showAlertDialog(context,
                                  "Alle Dokumenten wurden erfolgreich hochgeladen");
                            }
                          });
                        } else {
                          ConnectionDialog().showAlertDialog(
                              context, uploadDialogTitle, notConnectedInternet);
                        }
                      },
                      //formFeedback(context),
                    ),
                  ),
                  _padding(),
                  Text(
                      'Was wir von Dir mindestens  brauchen, um deinen Fall bearbeiten zu können:\n\n- Verwarnungsbogen\n- Bußgeldbescheid und/oder\n- Anhörungsbogen'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _add() async {
    final uid = (_firebaseAuth.currentUser.uid);
    Map<String, dynamic> data = <String, dynamic>{
      "name": documentName,
      "fileURLs": FieldValue.arrayUnion(_fileURLs)
    };
    await db
        .collection("userData")
        .doc(uid)
        .collection("Files")
        .add(data)
        .whenComplete(() {
      print("Document Added");
    });
    clearAll();
  }

  Widget _buildGridViewForOverview() {
    fetchData();
    return _getImages.length == 0
        ? const Text(
            'Kein Dokument',
            textAlign: TextAlign.center,
          )
        : GridView.builder(
            itemCount: _getImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 6, mainAxisSpacing: 6),
            itemBuilder: (context, index) {
              return Container(
                child: GestureDetector(
                  onTap: () {
                    print("YEs");
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenImage(
                        imageUrl: _getImages[index],
                        tag: "generate_a_unique_tag",
                      );
                    }));
                  },
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/loading.gif",
                    image: _getImages[index],
                    fit: BoxFit.fill,
                  ),
                ),
              );
            });
  }

  fetchData() async {
    List<String> img = [];
    var data = await FirebaseFirestore.instance
        .collection("userData")
        .doc(_firebaseAuth.currentUser.uid)
        .collection("Files")
        .get();
    for (int i = 0; i < data.docs.length; i++) {
      DocumentSnapshot files = data.docs[i];
      List<dynamic> images = files['fileURLs'];
      //print(images);
      for (int j = 0; j < images.length; j++) img.add(images[j]);
    }
    _getImages.clear();
    _getImages = img;
    //print(_getImages);
    if (mounted) {
      setState(() {});
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
                            _id = index;
                            _image.removeAt(_id);
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.grey[50],
                            child: CircleAvatar(
                                radius: 12.0,
                                backgroundColor: Colors.blue,
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

  chooseImage(ImageSource _source) async {
    final pickedFile = await picker.getImage(source: _source);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
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

  showAlertDialog(BuildContext context, String dialog) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Dokument hochladen"),
      content: Text(dialog),
      actions: [
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
}
