import 'package:flutter/widgets.dart';

class PageRouteTransition extends PageRouteBuilder {
  final Widget widget;
  PageRouteTransition({this.widget})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            var begin = Offset(1, 0.0);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              child: child,
              position: offsetAnimation,
            );
          },
        );
}
