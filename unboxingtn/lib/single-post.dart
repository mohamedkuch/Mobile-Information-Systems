import 'package:flutter/material.dart';
import 'package:unboxingtn/Posts.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

const MaterialColor white_color = MaterialColor(
  0xFFe1e1e1,
  <int, Color>{
    50: Color(0xFFe1e1e1),
    100: Color(0xFFe1e1e1),
    200: Color(0xFFe1e1e1),
    300: Color(0xFFe1e1e1),
    400: Color(0xFFe1e1e1),
    500: Color(0xFFe1e1e1),
    600: Color(0xFFe1e1e1),
    700: Color(0xFFe1e1e1),
    800: Color(0xFFe1e1e1),
    900: Color(0xFFe1e1e1),
  },
);

const MaterialColor primary_Color = MaterialColor(
  0xFFF43D2A,
  <int, Color>{
    50: Color(0xFFF87F73),
    100: Color(0xFFF43D2A),
    200: Color(0xFFF43D2A),
    300: Color(0xFFF43D2A),
    400: Color(0xFFF43D2A),
    500: Color(0xFFF43D2A),
    600: Color(0xFFF43D2A),
    700: Color(0xFFF43D2A),
    800: Color(0xFFF43D2A),
    900: Color(0xFFC71C0A),
  },
);

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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
