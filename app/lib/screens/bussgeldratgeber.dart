import 'package:app/models/post.dart';
import 'package:app/screens/bussgeldratgeberdetail.dart';
import 'package:app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/pagetitle.dart';
import 'package:app/functions/newscreen.dart';

class BussgeldratgeberScreen extends StatelessWidget {
  final HttpService httpService = HttpService();
  _imageButton(text, [context, screen]) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15.0)),
        onPressed: () => {
          if (context == null || screen == null)
            {print('_simpleButton() pressed')}
          else
            {
              newScreen(
                context: context,
                screen: screen,
              )
            }
        },
        child: Column(
          children: [
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          _imageButton(posts[index].title.rendered);
                          return PostTile(
                            title: posts[index].title.rendered,
                            thumbnailUrl: posts[index]
                                .embedded
                                .wpFeaturedmedia[0]
                                .mediaDetails
                                .sizes
                                .onepressBlogSmall
                                .sourceUrl,
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
  final String title;
  final String thumbnailUrl;
  final Post post;

  PostTile({this.title, this.thumbnailUrl, this.post});

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
                image: thumbnailUrl,
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                //color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
