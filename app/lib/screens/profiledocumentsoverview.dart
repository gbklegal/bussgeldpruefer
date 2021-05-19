import 'dart:io';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class ProfileDocumentsOverviewScreen extends StatefulWidget {
  @override
  _ProfileDocumentsOverviewScreenState createState() =>
      _ProfileDocumentsOverviewScreenState();
}

class _ProfileDocumentsOverviewScreenState
    extends State<ProfileDocumentsOverviewScreen> {
  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;

  List<File> _image = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _id;

  Widget _buildGridView() {
    return _image.length == 0
        ? const Text(
            'No Image Selected',
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
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: FileImage(_image[index]), fit: BoxFit.cover)),
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
        await ref.getDownloadURL().then((value) {
          //imgRef.add({'url': value});
          i++;
        });
      });
    }
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
    Future formFeedback(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Geschafft!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Deine Dokumente wurden '),
                      TextSpan(
                          text: 'erfolgreich',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' eingereicht.'),
                    ],
                  ),
                ),
                _padding(),
                Image.asset(
                  'assets/icons/confetti.png',
                  width: 80,
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('schließen'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }

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
                                'uploading...',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator(
                              value: val,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            )
                          ],
                        ))
                      : Container(),
                  _padding(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('senden'),
                      onPressed: () {
                        setState(() {
                          uploading = true;
                        });
                        uploadFile()
                            .whenComplete(() => Navigator.of(context).pop());
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
}
