import 'package:app/global.dart';
import 'package:app/models/post.dart';
import 'package:app/screens/bussgeldratgeberdetail.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/services/http_service.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';

import '../constants.dart';

class BussgeldratgeberScreen extends StatefulWidget {
  @override
  _BussgeldratgeberScreenState createState() => _BussgeldratgeberScreenState();
}

class _BussgeldratgeberScreenState extends State<BussgeldratgeberScreen>
    with WidgetsBindingObserver {
  final HttpService httpService = HttpService();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _checkConnection();
      });
    }
  }

  _checkConnection() async {
    isConnection = await ConnectionStatus().checkConnectionStatus();
  }

  @override
  Widget build(BuildContext context) {
    _checkConnection();
    isConnection
        ? Container()
        : Future.delayed(Duration(seconds: 5), () async {
            ConnectionDialog().showAlertDialog(
                context, loginDialogTitle, notConnectedInternet);
          });
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          PageTitle('Bußgeld Ratgeber',
              'In unserem Bußgeld Ratgeber findest du aktuelle Bußgelder, Punkte & Fahrverbote. Hier kannst Du Dich über Bußgelder im Straßenverkehr informieren.'),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: httpService.getPosts(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.hasData) {
                    List<Post> posts = snapshot.data;
                    return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostTile(
                            post: posts[index],
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BussgeldRatgeberDetailScreen(post)),
          );
        },
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15.0)),
        child: Column(
          children: [
            Container(
              height: 140.0,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/loading.gif",
                image: post.embedded.wpFeaturedmedia[0].mediaDetails.sizes
                    .onepressBlogSmall.sourceUrl,
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(post.title.rendered),
            ),
          ],
        ),
      ),
    );
  }
}
