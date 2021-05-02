import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unboxingtn/carousel/carousel-top.dart';
import 'package:unboxingtn/login.dart';
import 'package:unboxingtn/main/main-card.dart';
import 'package:unboxingtn/top/search-bar.dart';
import 'package:unboxingtn/top/top-bar.dart';
import 'package:unboxingtn/services.dart';
import 'package:unboxingtn/Posts.dart';
import 'package:unboxingtn/colors.dart';
import 'package:unboxingtn/transition/PageRouteTransition.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> _posts;

  List<Post> _searchPosts;

  bool _isLoading;
  bool _isMoreLoading = false;
  int _currentPage = 1;
  int _pageCount = 0;

  String searchString = "";
  bool _searchLoading;

  String skipLogin = "";

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
        onTap: (int index) {
          if (index == 0) {
            setState(() {
              searchString = "";
            });
          }
        },
      ),
    );
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var skipLoginTmp = sharedPreferences.getString("skipLogin");
    setState(() {
      skipLogin = skipLoginTmp;
    });
    print(skipLogin);
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      if (skipLogin == null || skipLogin == "") {
        Timer(Duration(milliseconds: 10), () {
          Navigator.push(
            context,
            PageRouteTransition(
              widget: Login(),
            ),
          );
        });
      }
    });

    _isLoading = true;
    Services.getPosts(_currentPage).then((data) {
      setState(() {
        _posts = data['posts'];
        _pageCount = data['count'];
        _isLoading = false;
      });
    });
    super.initState();
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
      _searchLoading = true;
      _searchPosts = [];
    });
    Services.getSearchPosts(1, searchString).then((data) {
      setState(() {
        _searchPosts = data['posts'];
        _searchLoading = false;
      });
    });
  }

  Widget mainContainer() {
    if (searchString == "") {
      return MainCard(_posts);
    }
    if (_searchLoading) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return MainCard(_searchPosts);
  }

  Widget loadMoreButton() {
    if (searchString == "") {
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
    return Padding(padding: EdgeInsets.all(2));
  }

  Widget searchTop() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "نتائج البحث عن : $searchString",
                    style: TextStyle(
                      fontFamily: 'MarkaziText',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(2)),
          Divider(
            height: 3,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          Padding(padding: EdgeInsets.all(2))
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
        leading: new Container(),
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
                      searchFunction: searchStringFunction,
                      searchString: searchString,
                    ),
                    searchString != ""
                        ? searchTop()
                        : CarouselWithIndicatorDemo(_posts.sublist(0, 5)),
                    mainContainer(),
                    loadMoreButton(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
