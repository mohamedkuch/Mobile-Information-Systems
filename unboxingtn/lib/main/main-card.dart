import 'package:flutter/material.dart';
import 'package:html/dom.dart' as htmlParser;
import 'package:unboxingtn/Posts.dart';
import 'package:unboxingtn/single-post.dart';

class MainCard extends StatelessWidget {
  final List<Post> posts;
  MainCard(this.posts);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (ctx, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Card(
              child: InkWell(
                splashColor: Color.fromRGBO(195, 48, 33, 0.2),
                onTap: () {
                  print('Card tapped.');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SinglePost(posts[index])),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/img_placeholder_main.jpg'),
                            width: MediaQuery.of(context).size.width * 0.38,
                            height: 100,
                            fit: BoxFit.cover,
                            image: NetworkImage(posts[index]
                                .embedded
                                .wpFeaturedmedia[0]
                                .sourceUrl),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*2*/
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 3,
                                  ),
                                  child: Text(
                                    posts[index].title.rendered,
                                    style: TextStyle(
                                      fontFamily: 'MarkaziText',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Divider(
                                    height: 3,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  htmlParser.DocumentFragment.html(
                                          posts[index].excerpt.rendered)
                                      .text,
                                  // snapshot.data[index]["excerpt"]["rendered"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: 'MarkaziText',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
