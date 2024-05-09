import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final Function() onTap;

  CustomPageRoute({required this.child, required this.onTap})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.easeOutExpo;

            var slideAnimation =
                Tween(begin: begin, end: end).animate(CurvedAnimation(parent: animation, curve: curve));


            var fadeAnimation =
                Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve));

            return GestureDetector(
              onTap: onTap,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: fadeAnimation,
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: child,
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 800),
        );
}
