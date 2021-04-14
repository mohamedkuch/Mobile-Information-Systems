import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as htmlParser;

class MainCard extends StatelessWidget {
  final snapshot;
  MainCard(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (ctx, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Card(
              child: InkWell(
                splashColor: Color.fromRGBO(195, 48, 33, 0.2),
                onTap: () {
                  print('Card tapped.');
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
                            image: NetworkImage(
                              snapshot.data[index]["_embedded"]
                                  ['wp:featuredmedia'][0]['source_url'],
                            ),
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
                                    snapshot.data[index]["title"]["rendered"],
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
                                  htmlParser.DocumentFragment.html(snapshot
                                          .data[index]["excerpt"]["rendered"])
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

                  // child: Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: <Widget>[
                  //     Directionality(
                  //       textDirection: TextDirection.rtl,
                  //       child: ListTile(
                  //         leading: ClipRRect(
                  //           borderRadius: BorderRadius.circular(5.0),
                  //           child: Image.network(
                  //             snapshot.data[index]["_embedded"]
                  //                 ['wp:featuredmedia'][0]['source_url'],
                  //             width: 100,
                  //             height: 300,
                  //           ),
                  //         ),
                  //         title: Text(
                  //           snapshot.data[index]["title"]["rendered"],
                  //           style: GoogleFonts.markaziText(
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //         subtitle: Text(
                  //           htmlParser.DocumentFragment.html(
                  //                   snapshot.data[index]["excerpt"]["rendered"])
                  //               .text,
                  //           overflow: TextOverflow.ellipsis,
                  //           maxLines: 3,
                  //           style: GoogleFonts.markaziText(
                  //             fontSize: 12,
                  //           ),
                  //         ),
                  //         isThreeLine: true,
                  //       ),
                  //     ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: <Widget>[
                  //     TextButton(
                  //       child: const Text('BUY TICKETS'),
                  //       onPressed: () {/* ... */},
                  //     ),
                  //     const SizedBox(width: 8),
                  //     TextButton(
                  //       child: const Text('LISTEN'),
                  //       onPressed: () {/* ... */},
                  //     ),
                  //     const SizedBox(width: 8),
                  //   ],
                  // ),
                  // ],
                  // ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
