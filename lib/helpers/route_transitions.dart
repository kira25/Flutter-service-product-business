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
      this.replacement = false}){
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
