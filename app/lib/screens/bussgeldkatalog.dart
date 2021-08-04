import 'package:app/constants.dart';
import 'package:app/models/post.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/services/http_service.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:app/screens/bussgeldkatalogdetail.dart';

import '../global.dart';

class BussgeldkatalogScreen extends StatefulWidget {
  @override
  _BussgeldkatalogScreenState createState() => _BussgeldkatalogScreenState();
}

class _BussgeldkatalogScreenState extends State<BussgeldkatalogScreen>
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
          PageTitle('Bußgeldkatalog',
              'In den unterschiedlichen Kategorien findest Du aktuelle Informationen zum Thema Verkehrsrecht. Es wird erklärt wann mit Bußgeldern, Punkten oder sogar Fahrverbot zu rechnen ist.'),
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
                          return CatalogTile(
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

class CatalogTile extends StatelessWidget {
  final Post post;

  CatalogTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BussgeldkatalogDetailScreen(post)),
          );
        },
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15.0)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(post.title.rendered),
        ),
      ),
    );
  }
}
