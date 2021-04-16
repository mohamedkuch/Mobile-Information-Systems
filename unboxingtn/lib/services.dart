import 'Posts.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<Post>> getPosts(pageNumber) async {
    var queryParameters = {
      'per_page': '5',
      '_embed': 'true',
      'page': pageNumber.toString(),
    };
    try {
      final res = await http.get(
          Uri.https(
              'www.unboxingtn.com', '/wp-json/wp/v2/posts', queryParameters),
          headers: {'Accept': 'application/json'});

      if (res.statusCode == 200) {
        final List<Post> posts = postFromJson(res.body);
        for (var item in res.headers.entries) {
          if (item.key == 'x-wp-totalpages') {
            print(item.value);
          }
          //print(item.value);
        }

        return posts;
      } else {
        // ignore: deprecated_member_use
        return List<Post>();
      }
    } catch (e) {
      // ignore: deprecated_member_use
      return List<Post>();
    }
  }
}
