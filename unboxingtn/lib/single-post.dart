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
            Text(widget.post.title.rendered),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
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
