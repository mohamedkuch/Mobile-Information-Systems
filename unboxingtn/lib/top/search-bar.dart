import 'package:flutter/material.dart';
import 'package:unboxingtn/Posts.dart';
import 'package:unboxingtn/colors.dart';

class SearchBar extends StatefulWidget {
  final List<Post> posts;
  final searchFunction;
  SearchBar({Key key, this.posts, this.searchFunction}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _showClearButton = false;
  final TextEditingController _textEditingController = TextEditingController();

  Widget _getClearButton() {
    if (!_showClearButton) {
      return null;
    }
    return IconButton(
      onPressed: () {
        widget.searchFunction("");
        _textEditingController.clear();
      },
      icon: Icon(
        Icons.clear,
        color: primary_Color,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _showClearButton = _textEditingController.text.length > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              onSubmitted: (text) {
                widget.searchFunction(text);
              },
              onChanged: (text) {
                if (text == "") {
                  widget.searchFunction(text);
                }
              },
              controller: _textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black87,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black38,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'بحث',
                hintStyle: TextStyle(fontSize: 15),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black45,
                  size: 20.0,
                ),
                suffixIcon: _getClearButton(),
                hintTextDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
