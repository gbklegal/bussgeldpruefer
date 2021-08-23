import 'package:app/global.dart';
import 'package:app/models/post.dart';
import 'package:app/screens/bussgeldratgeberdetail.dart';
import 'package:app/services/connectivity.dart';
import 'package:app/services/http_service.dart';
import 'package:app/utilities/connection_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../constants.dart';

class BussgeldratgeberScreen extends StatefulWidget {
  @override
  _BussgeldratgeberScreenState createState() => _BussgeldratgeberScreenState();
}

class _BussgeldratgeberScreenState extends State<BussgeldratgeberScreen>
    with WidgetsBindingObserver {
  final HttpService httpService = HttpService();
  List<Post> posts;
  int pageNumber = 1;
  var data;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    ++pageNumber;
    data = await httpService.getPosts(pageNumber);
    if (data == null) {
      return _refreshController.loadNoData();
    } else
      posts += data;

    if (mounted) setState(() {});

    _refreshController.loadComplete();
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
          Expanded(
            child: FutureBuilder(
              future: httpService.getPosts(pageNumber),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                if (snapshot.hasData) {
                  if (pageNumber == 1) {
                    posts = snapshot.data;
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
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostTile(
                            post: posts[index],
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

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BussgeldRatgeberDetailScreen(post)),
          );
        },
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15.0)),
        child: Container(
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
      ),
    );
  }
}
