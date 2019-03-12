import 'package:flutter/material.dart';

class CustomizeRoute extends PageRouteBuilder {
  final Widget widget;

  CustomizeRoute(this.widget)
      : super(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (BuildContext context,
                Animation<double> animationStart,
                Animation<double> animationEnd) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animationStart,
                Animation<double> animationEnd,
                Widget child) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animationStart, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
