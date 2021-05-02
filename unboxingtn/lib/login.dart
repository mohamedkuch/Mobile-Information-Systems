import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unboxingtn/colors.dart';
import 'package:unboxingtn/transition/PageRouteTransition.dart';
import 'home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Create storage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_Color,
      body: Column(
        children: [
          Container(
            // padding: EdgeInsets.only(
            //   top: MediaQuery.of(context).size.height * 0.1,
            //   bottom: MediaQuery.of(context).size.height * 0.1,
            // ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset('assets/logo.png'),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      hintText: 'Email or Username',
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30, top: 50),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: white_color,
                        onPrimary: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString('skipLogin', "true");
                      Navigator.push(
                        context,
                        PageRouteTransition(
                          widget: Home(),
                        ),
                      );
                    },
                    child: Container(
                      child: Text(
                        "skip this step >>",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
