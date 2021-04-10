import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TopBar extends StatelessWidget {
  final snapshot;
  TopBar(this.snapshot);

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
                snapshot.data[0]["title"]["rendered"],
                snapshot.data[1]["title"]["rendered"],
                snapshot.data[2]["title"]["rendered"],
                snapshot.data[3]["title"]["rendered"],
                snapshot.data[4]["title"]["rendered"],
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
