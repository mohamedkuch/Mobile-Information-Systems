import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_render.dart';
import 'package:flutter_html/style.dart';
import 'package:unboxingtn/Posts.dart';
import 'colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

Widget _buttonHelper(String catListString, bool isPrimary) {
  return Container(
    margin: isPrimary ? EdgeInsets.only(right: 0) : EdgeInsets.only(right: 8),
    padding: EdgeInsets.only(
      top: 5,
      bottom: 5,
      left: 8,
      right: 8,
    ),
    decoration: BoxDecoration(
      color: isPrimary ? primary_Color : Colors.grey[600],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        isPrimary
            ? Icon(
                Icons.folder,
                color: Colors.white,
                size: 15,
              )
            : Icon(
                Icons.access_time_outlined,
                color: Colors.white,
                size: 15,
              ),
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(
            catListString,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

// title section
Widget titleSection(Post post) {
  String catListString = "";
  for (var item in post.embedded.wpTerm) {
    for (var single in item) {
      catListString += single.name + " , ";
    }
  }

  if (catListString == "") {
    catListString = "None";
  } else {
    catListString = catListString.substring(0, catListString.length - 2);
  }

  var dateFormatted = "${post.date.year}-${post.date.month}-${post.date.day}";

  return Container(
    padding: const EdgeInsets.only(
      top: 20,
      bottom: 20,
      left: 15,
      right: 15,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          post.title.rendered,
          style: TextStyle(
            fontFamily: 'MarkaziText',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              _buttonHelper(catListString, true),
              _buttonHelper(dateFormatted, false),
            ],
          ),
        )
      ],
    ),
  );
}

void _launchURL(customUrl) async => await canLaunch(customUrl)
    ? await launch(customUrl)
    : throw 'Could not launch $customUrl';

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Transform.scale(child: Image.asset('assets/logo.png'), scale: 0.6),
        centerTitle: true,
      ),
      body: Container(
        color: white_color,
        child: SafeArea(
          child: ListView(children: <Widget>[
            FadeInImage(
              placeholder: AssetImage('assets/img_placeholder.png'),
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                  widget.post.embedded.wpFeaturedmedia[0].sourceUrl),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: titleSection(widget.post),
            ),
            Divider(
              height: 2,
              thickness: 2,
              endIndent: 15,
              indent: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                  top: 10,
                ),
                child: new Html(
                  data: widget.post.content.rendered,
                  style: {
                    "strong": Style(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'MarkaziText',
                      fontSize: FontSize(18),
                    ),
                    ".has-vivid-red-color": Style(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(207, 46, 46, 1),
                    ),
                    "a": Style(textDecoration: TextDecoration.none),
                  },
                  onLinkTap: (String url) {
                    //open URL in webview, or launch URL in browser, or any other logic here
                    _launchURL(url);
                  },
                  customImageRenders: {
                    networkSourceMatcher(domains: ["www.unboxingtn.com"]):
                        (context, attributes, element) {
                      return FadeInImage(
                        placeholder:
                            AssetImage('assets/img_placeholder_main.jpg'),
                        fit: BoxFit.fitWidth,
                        width: double.parse(attributes['width']),
                        image: NetworkImage(
                          attributes['src'],
                        ),
                      );
                    },
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
