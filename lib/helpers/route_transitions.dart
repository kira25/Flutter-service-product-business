import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AnimationType { normal, fadeIn }

class CustomRouteTransition {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final bool replacement;

  CustomRouteTransition(
      {@required this.context,
      @required this.child,
      this.animation = AnimationType.normal,
      this.duration = const Duration(milliseconds: 300),
      this.replacement = false}) {
    switch (animation) {
      case AnimationType.normal:
        _normalTransition();
        break;
      case AnimationType.fadeIn:
        _fadeInTransition();
        break;
    }
  }

  void _normalTransition() => !replacement
      ? Navigator.push(
          context, MaterialPageRoute(builder: (context) => this.child))
      : Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => this.child));

  void _fadeInTransition() {
    final route = PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInCubic)),
            child: child,
          );
        });
    !replacement
        ? Navigator.push(context, route)
        : Navigator.pushReplacement(context, route);
  }
}

class CustomNavigatorPop {
  final BuildContext context;
  final String popPage;
  final Widget newRoute;

  CustomNavigatorPop(
      {this.newRoute, @required this.context, @required this.popPage}) {
    Navigator.popUntil(context, ModalRoute.withName(popPage));
    /*Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => newRoute,
        ),
        (ModalRoute.withName(popPage)));*/
  }
}

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  FadeInRoute({this.page, String routeName})
      : super(
    settings: RouteSettings(name: routeName),            // set name here
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
    transitionDuration: Duration(milliseconds: 500),
  );
}
