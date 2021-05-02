import 'package:flutter/material.dart';
import 'package:unboxingtn/carousel/carousel-top.dart';
import 'package:unboxingtn/main/main-card.dart';
import 'package:unboxingtn/top/search-bar.dart';
import 'package:unboxingtn/top/top-bar.dart';
import 'package:unboxingtn/services.dart';
import 'package:unboxingtn/Posts.dart';
import 'package:unboxingtn/colors.dart';

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
  int _currentPageSearch = 1;
  int _pageCountSearch = 0;
  bool _isMoreLoadingSearch = false;

  void searchStringFunction(value) {
    setState(() {
      searchString = value;
      _searchLoading = true;
      _searchPosts = [];
      _currentPageSearch = 1;
    });
    Services.getSearchPosts(1, searchString).then((data) {
      setState(() {
        _searchPosts = data['posts'];
        _pageCountSearch = data['count'];
        print(_pageCountSearch);
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

  @override
  void initState() {
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

  void requestMorePostSearch() {
    setState(() {
      _isMoreLoadingSearch = true;
      _currentPageSearch += 1;
    });

    Services.getSearchPosts(_currentPageSearch, searchString).then((data) {
      setState(() {
        _searchPosts += data['posts'];
        _isMoreLoadingSearch = false;
      });
    });
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

    if (_currentPageSearch >= _pageCountSearch &&
        !_isMoreLoadingSearch &&
        !_searchLoading) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: 10,
        ),
        child: Center(
          child: Text("No more articles left"),
        ),
      );
    }
    if (_searchLoading) {
      return Padding(padding: EdgeInsets.all(5));
    }
    if (_isMoreLoadingSearch) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        child: Center(
          child: Container(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Padding(
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
          print('Pressed More search ');
          requestMorePostSearch();
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {},
          ),
        ],
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
    );
  }
}
