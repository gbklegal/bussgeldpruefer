import 'dart:convert';

import 'package:app/models/post.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsUrl =
      "https://xn--bussgeldprfer-5ob.com/wp-json/wp/v2/posts?_embed";

  Future<List<Post>> getPosts() async {
    Response response = await get(
      Uri.parse(postsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    try {
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Post> posts =
            body.map((dynamic item) => Post.fromJson(item)).toList();
        return posts;
      } else {
        throw "Can't get posts.";
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}
