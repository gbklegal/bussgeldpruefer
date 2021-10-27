import 'dart:convert';

import 'package:app/models/post.dart';
import 'package:app/models/docs.dart';
import 'package:http/http.dart';

class HttpService {
  // ignore: missing_return
  Future<List<Post>> getPosts(pageNumber) async {
    Response response = await get(Uri.parse(
        "https://xn--bussgeldprfer-5ob.com/bgp/wp-api.php/posts?page=$pageNumber&_embed&_fields=id,date,link,title,content,_links,_embedded"));
    try {
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var posts = List<Post>.from(body.map((model) => Post.fromJson(model)));
        return posts;
      } else if (response.statusCode == 400) {
        return null;
      } else
        throw "Can't get posts.";
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  // ignore: missing_return
  Future<List<Docs>> getDocs(pageNumber) async {
    Response response = await get(Uri.parse(
        "https://xn--bussgeldprfer-5ob.com/bgp/wp-api.php/docs?page=$pageNumber&_embed&_fields=id,date,link,title,content,_links,_embedded"));
    try {
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var docs = List<Docs>.from(body.map((model) => Docs.fromJson(model)));
        return docs;
      } else if (response.statusCode == 400) {
        return null;
      } else
        throw "Can't get posts.";
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}
