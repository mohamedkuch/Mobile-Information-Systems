import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as htmlParser;

class MainCard extends StatelessWidget {
  final snapshot;
  MainCard(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (ctx, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  splashColor: Color.fromRGBO(225, 225, 225, 0.4),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              snapshot.data[index]["_embedded"]
                                  ['wp:featuredmedia'][0]['source_url'],
                              width: 100,
                            ),
                          ),
                          title: Text(
                            snapshot.data[index]["title"]["rendered"],
                            style: GoogleFonts.markaziText(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            htmlParser.DocumentFragment.html(
                                    snapshot.data[index]["excerpt"]["rendered"])
                                .text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: GoogleFonts.markaziText(
                              fontSize: 12,
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      ),
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
                    ],
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
