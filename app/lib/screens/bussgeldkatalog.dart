import 'package:app/models/post.dart';
import 'package:app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:app/screens/bussgeldkatalogdetail.dart';

class BussgeldkatalogScreen extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
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
