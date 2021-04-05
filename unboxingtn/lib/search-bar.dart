import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
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
            hintTextDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}
