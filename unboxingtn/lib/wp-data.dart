import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future fetchWpPosts(pageNumber) async {
  var queryParameters = {
    'per_page': '5',
    '_embed': 'true',
    'page': pageNumber.toString(),
  };

  final res = await http.get(
      Uri.https('www.unboxingtn.com', '/wp-json/wp/v2/posts', queryParameters),
      headers: {'Accept': 'application/json'});
  print(res.statusCode);

  if (res.statusCode == 200) {
    final convertDatatoJson = convert.jsonDecode(res.body);
    return convertDatatoJson;
  }

  return null;
}

// Future<http.Response> fetchWpPosts() async {
//   var queryParameters = {
//     'per_page': '5',
//     '_embed': 'true',
//   };

//   final response = await http.get(
//       Uri.https('www.unboxingtn.com', '/wp-json/wp/v2/posts', queryParameters));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return convert.jsonDecode(response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

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
