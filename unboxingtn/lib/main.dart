import 'package:flutter/material.dart';
import 'package:unboxingtn/carousel/carousel-top.dart';
import 'package:unboxingtn/main/main-card.dart';
import 'package:unboxingtn/top/search-bar.dart';
import 'package:unboxingtn/top/top-bar.dart';
import 'package:unboxingtn/services.dart';
import 'package:unboxingtn/Posts.dart';
import 'package:unboxingtn/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: primary_Color,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primary_Color,
          ),
        ),
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
  );
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> _posts;
  bool _isLoading;
  bool _isMoreLoading = false;
  int _currentPage = 1;
  int _pageCount = 0;
  String searchString = "";

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Services.getPosts(_currentPage).then((data) {
      setState(() {
        _posts = data['posts'];
        _pageCount = data['count'];
        _isLoading = false;
      });
    });
  }

  void requestMorePost() {
    setState(() {
      _isMoreLoading = true;
      _currentPage += 1;
    });

    Services.getPosts(_currentPage).then((data) {
      setState(() {
        _posts += data['posts'];
        _isMoreLoading = false;
      });
    });
  }

  void searchStringFunction(value) {
    setState(() {
      searchString = value;
      print(searchString);
    });
  }

  Widget loadMoreButton() {
    if (_currentPage > _pageCount && !_isMoreLoading) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: 10,
        ),
        child: Center(
          child: Text("No more articles left"),
        ),
      );
    }
    return _isMoreLoading
        ? Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Center(
              child: Container(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 10,
            ),
            child: ElevatedButton.icon(
              label: Text(
                'Load More',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: Icon(Icons.add_circle_outline_rounded),
              onPressed: () {
                print('Pressed');
                requestMorePost();
              },
            ),
          );
  }

  Widget searchTop() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Text(
              "نتائج البحث عن : $searchString",
              style: TextStyle(
                fontFamily: 'MarkaziText',
                fontSize: 20.0,
              ),
            ),
          ),
          Divider(
            height: 5,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          Padding(padding: EdgeInsets.all(5))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Transform.scale(child: Image.asset('assets/logo.png'), scale: 0.6),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: white_color,
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    TopBar(_posts.sublist(0, 5)),
                    Divider(
                      height: 5,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                    ),
                    SearchBar(
                      posts: _posts,
                      searchFunction: searchStringFunction,
                    ),
                    searchString != ""
                        ? searchTop()
                        : CarouselWithIndicatorDemo(_posts.sublist(0, 5)),
                    MainCard(_posts),
                    loadMoreButton(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
