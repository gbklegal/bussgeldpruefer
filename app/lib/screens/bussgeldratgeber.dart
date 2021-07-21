import 'package:app/models/post.dart';
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

  _padding() {
    return SizedBox(height: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PageTitle('Bußgeld Ratgeber',
                  'In unserem Bußgeld Ratgeber findest du aktuelle Bußgelder, Punkte & Fahrverbote. Hier kannst Du Dich über Bußgelder im Straßenverkehr informieren.'),
              Container(
                width: double.infinity,
                height: 500,
                child: FutureBuilder(
                  future: httpService.getPosts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Post>> snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      List<Post> posts = snapshot.data;
                      return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            _imageButton(posts[index].title.rendered);
                            return ListTile(
                              title: Text(posts[index].title.rendered),
                              subtitle: Text(posts[index]
                                  .embedded
                                  .wpFeaturedmedia[0]
                                  .mediaDetails
                                  .sizes
                                  .onepressBlogSmall
                                  .sourceUrl),
                            );
                          });
                      //   (
                      //   children: posts
                      //       .map((Post post) => ListTile(
                      //             title: Text(post.title.rendered),
                      //             // subtitle: Text(post
                      //             //     .embedded
                      //             //     .wpFeaturedmedia[0]
                      //             //     .mediaDetails
                      //             //     .sizes
                      //             //     .onepressBlogSmall
                      //             //     .sourceUrl),
                      //           ))
                      //       .toList(),
                      // );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              //Padding(
              //padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              // child: FutureBuilder(
              //   future: httpService.getPosts(),
              //   builder:
              //       (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
              //     print(snapshot.data);
              //     if (snapshot.hasData) {
              //       List<Post> posts = snapshot.data;

              //       return ListView(
              //         children: posts
              //             .map((Post post) => ListTile(
              //                   title: Text(post.),
              //                 ))
              //             .toList(),
              //       );
              //     }
              //     return Center(child: CircularProgressIndicator());
              //   },
              // ),
              // Column(
              //   children: [
              //     _imageButton(
              //       'In der 30er Zone geblitzt?',
              //       context,
              //       BussgeldRatgeberDetailScreen('In der 30er Zone geblitzt?'),
              //     ),
              //     _padding(),
              //     _imageButton('In der 30er Zone geblitzt?'),
              //   ],
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
