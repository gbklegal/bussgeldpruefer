import 'dart:convert';

import 'package:app/models/post.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsUrl =
      "https://xn--bussgeldprfer-5ob.com/wp-json/wp/v2/posts?_embed&_fields=id,date,link,title,content,_links,_embedded";
  // ignore: missing_return
  Future<List<Post>> getPosts() async {
    Response response = await get(Uri.parse(postsUrl));
    try {
      if (response.statusCode == 200) {
        Iterable body = jsonDecode(response.body);
        List<Post> posts =
            List<Post>.from(body.map((model) => Post.fromJson(model)));
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
