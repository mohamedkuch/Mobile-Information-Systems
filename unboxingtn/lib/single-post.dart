import 'package:flutter/material.dart';
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

// title section
Widget titleSection(Post post) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title.rendered,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text("aaa")
      ],
    ),
  );
}

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
              placeholder: AssetImage('assets/img_placeholder.jpg'),
              width: MediaQuery.of(context).size.width * 0.38,
              height: 240,
              fit: BoxFit.cover,
              image: NetworkImage(
                  widget.post.embedded.wpFeaturedmedia[0].sourceUrl),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: titleSection(widget.post),
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
