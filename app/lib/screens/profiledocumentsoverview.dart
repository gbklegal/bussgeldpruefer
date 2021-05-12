import 'dart:io';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDocumentsOverviewScreen extends StatefulWidget {
  @override
  _ProfileDocumentsOverviewScreenState createState() =>
      _ProfileDocumentsOverviewScreenState();
}

class _ProfileDocumentsOverviewScreenState
    extends State<ProfileDocumentsOverviewScreen> {
  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 13.0, right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    snapshot.data,
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
                    Navigator.pop(context, true);
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
          );
          // Card(
          //   elevation: 5,
          //   margin: EdgeInsets.all(10),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(16.0),
          //   ),
          //   child: Image.file(
          //     snapshot.data,
          //     fit: BoxFit.fill,
          //     width: 100.0,
          //     height: 100.0,
          //   ),
          // );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
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
      body: ListView(
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
                showImage(),
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
                        onPressed: () =>
                            pickImageFromGallery(ImageSource.gallery),
                        // print('Get photo from library.'),
                      ),
                    ),
                  ],
                ),
                _padding(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('senden'),
                    onPressed: () => formFeedback(context),
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
    );
  }
}
