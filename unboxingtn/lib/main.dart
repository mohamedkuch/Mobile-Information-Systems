import 'package:flutter/material.dart';
import 'package:unboxingtn/home.dart';
import 'package:unboxingtn/colors.dart';
import 'package:unboxingtn/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Read value
    return MaterialApp(
      title: 'Unboxing TN',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: primary_Color,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primary_Color,
          ),
        ),
      ),
      home: Home(),
    );
  }
}
