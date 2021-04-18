import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_render.dart';
import 'package:flutter_html/style.dart';
import 'package:unboxingtn/Posts.dart';
import 'colors.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

Widget bottomNavigation() {
  return Container(
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          blurRadius: 2,
        ),
      ],
    ),
    child: BottomNavigationBar(
      elevation: 2,
      currentIndex: 1,
      selectedItemColor: Colors.grey[600],
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    ),
  );
}

Widget _buttonHelper() {
  return Container(
    padding: EdgeInsets.only(
      top: 5,
      bottom: 5,
      left: 8,
      right: 8,
    ),
    decoration: BoxDecoration(
      color: primary_Color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      "aaa",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}

// title section
Widget titleSection(Post post) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          post.title.rendered,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              _buttonHelper(),
              _buttonHelper(),
            ],
          ),
        )
      ],
    ),
  );
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    print(widget.post.content.rendered);
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
              placeholder: AssetImage('assets/img_placeholder.jpg'),
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
                    ),
                    ".has-vivid-red-color": Style(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(207, 46, 46, 1),
                    ),
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

            // buttonSection,
            // textSection,
          ]),
        ),

        // Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text('Go back!'),
        //   ),
        // ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
