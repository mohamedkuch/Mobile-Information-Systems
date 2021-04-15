import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:unboxingtn/Posts.dart';

class TopBar extends StatelessWidget {
  final List<Post> posts;
  TopBar(this.posts);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.centerRight,
            child: TyperAnimatedTextKit(
              text: [
                posts[0].title.rendered,
                posts[1].title.rendered,
                posts[2].title.rendered,
                posts[3].title.rendered,
                posts[4].title.rendered,
              ],
              textStyle: TextStyle(fontSize: 13),
              speed: Duration(milliseconds: 80),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
                bottom: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                width: 28,
                height: 28,
                child: Icon(
                  Icons.bolt,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
