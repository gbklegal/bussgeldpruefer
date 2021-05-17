import 'dart:io';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ProfileDocumentsOverviewScreen extends StatefulWidget {
  @override
  _ProfileDocumentsOverviewScreenState createState() =>
      _ProfileDocumentsOverviewScreenState();
}

class _ProfileDocumentsOverviewScreenState
    extends State<ProfileDocumentsOverviewScreen> {
  Future<File> imageFile;
  List<Asset> images = <Asset>[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  uploadImage() async {
    setState(() {
      isLoading = true;
    });
    for (var imageFile in images) {
      await postImage(imageFile).then((downloadUrl) {
        // Get the download URL and do your stuff here
      }).catchError((err) {
        print(err);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    double imageDesiredWidth = 500;

    double getAspectRatio(double originalSize, double desiredSize) =>
        desiredSize / originalSize;
    final aspectRatio =
        getAspectRatio(imageFile.originalWidth.toDouble(), imageDesiredWidth);
    ByteData byteData = await imageFile.getThumbByteData(
      (imageFile.originalWidth * aspectRatio).round(),
      (imageFile.originalHeight * aspectRatio).round(),
      quality: 100,
    );

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putData(byteData.buffer.asUint8List());
    TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => null);

    return await storageTaskSnapshot.ref.getDownloadURL();
  }

  Future<void> pickImages() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "Select Photos",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      images = resultList;
    });
  }

  Widget buildGridView() {
    if (images.isNotEmpty) {
      return GridView.count(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 100,
            height: 130,
          );
        }),
      );
    } else {
      return const Text(
        'No Image Selected',
        textAlign: TextAlign.center,
      );
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
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 130,
                    ),
                    child: buildGridView(),
                  ),
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
                          onPressed: () => pickImages(),
                          //pickImageFromGallery(ImageSource.gallery),
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
                      onPressed: () {
                        uploadImage();
                      },
                      //formFeedback(context),
                    ),
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : Visibility(visible: false, child: Text("test")),
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
