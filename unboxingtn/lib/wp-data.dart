import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future fetchWpPosts() async {
  var queryParameters = {
    'per_page': '5',
    '_embed': 'true',
  };

  final res = await http.get(
      Uri.https('www.unboxingtn.com', '/wp-json/wp/v2/posts', queryParameters),
      headers: {'Accept': 'application/json'});

  if (res.statusCode != 404) {
    final convertDatatoJson = convert.jsonDecode(res.body);
    return convertDatatoJson;
  }

  return null;
}

Future fetchWpCategories() async {
  var queryParameters = {'_embed': 'true', 'orderby': 'count', 'order': 'desc'};

  final res = await http.get(
      Uri.https(
          'www.unboxingtn.com', '/wp-json/wp/v2/Categories', queryParameters),
      headers: {'Accept': 'application/json'});

  if (res.statusCode != 404) {
    final convertDatatoJson = convert.jsonDecode(res.body);
    return convertDatatoJson;
  }

  return null;
}
