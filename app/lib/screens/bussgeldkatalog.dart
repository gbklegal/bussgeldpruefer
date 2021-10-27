import 'package:app/constants.dart';
import 'package:app/models/docs.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/services/http_service.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:app/screens/bussgeldkatalogdetail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../global.dart';

class BussgeldkatalogScreen extends StatefulWidget {
  @override
  _BussgeldkatalogScreenState createState() => _BussgeldkatalogScreenState();
}

class _BussgeldkatalogScreenState extends State<BussgeldkatalogScreen>
    with WidgetsBindingObserver {
  final HttpService httpService = HttpService();
  List<Docs> docs;
  int pageNumber = 1;
  var data;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _checkConnection();
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

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    ++pageNumber;
    data = await httpService.getDocs(pageNumber);
    if (data == null) {
      return _refreshController.loadNoData();
    } else
      docs += data;

    if (mounted) setState(() {});

    _refreshController.loadComplete();
  }

  _checkConnection() async {
    isConnection = await ConnectionStatus().checkConnectionStatus();
  }

  @override
  Widget build(BuildContext context) {
    isConnection
        ? Container()
        : Future.delayed(Duration(seconds: 3), () async {
            ConnectionDialog().showAlertDialog(
                context, loginDialogTitle, notConnectedInternet);
          });
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          PageTitle('Bußgeldkatalog',
              'In den unterschiedlichen Kategorien findest Du aktuelle Informationen zum Thema Verkehrsrecht. Es wird erklärt wann mit Bußgeldern, Punkten oder sogar Fahrverbot zu rechnen ist.'),
          Expanded(
            child: FutureBuilder(
              future: httpService.getDocs(pageNumber),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Docs>> snapshot) {
                if (snapshot.hasData) {
                  if (pageNumber == 1) {
                    docs = snapshot.data;
                  }
                  return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: false,
                    enablePullUp: true,
                    onLoading: _onLoading,
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("pull up load");
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("release to load more");
                        } else {
                          body = Text("");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          return CatalogTile(
                            docs: docs[index],
                          );
                        }),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CatalogTile extends StatelessWidget {
  final Docs docs;

  CatalogTile({this.docs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BussgeldkatalogDetailScreen(docs)),
          );
        },
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15.0)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(docs.title.rendered),
        ),
      ),
    );
  }
}
