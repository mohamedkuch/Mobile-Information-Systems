import 'package:flutter/material.dart';
import 'package:unboxingtn/carousel/carousel-top.dart';
import 'package:unboxingtn/top/search-bar.dart';
import 'package:unboxingtn/top/top-bar.dart';
import 'package:unboxingtn/wp-data.dart';

void main() {
  runApp(MyApp());
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: primary_Color,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Widget bodyContent(snapshot) {
  return ListView(
    children: <Widget>[
      TopBar(snapshot),
      Divider(
        height: 5,
        thickness: 2,
        indent: 15,
        endIndent: 15,
      ),
      SearchBar(),
      CarouselWithIndicatorDemo(snapshot),
      ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (ctx, int index) {
          return Container(
            child: Text(
              snapshot.data[index]["title"]["rendered"],
              textDirection: TextDirection.rtl,
            ),
          );
        },
      ),
    ],
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Transform.scale(child: Image.asset('assets/logo.png'), scale: 0.6),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchWpPosts(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              color: white_color,
              child: bodyContent(snapshot),
            );
          }),
      bottomNavigationBar: Container(
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
          currentIndex: 0,
          selectedItemColor: primary_Color[800],
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
      ),
    );
  }
}
