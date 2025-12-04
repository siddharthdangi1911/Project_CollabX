import 'package:flutter/material.dart';


class CustomPageRoute extends PageRouteBuilder{
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      var tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeOutCubic));

      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: animation.drive(tween),
          child: child,
        ),
      );
    },
  );
}

void nextPage(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(CustomPageRoute(child: page));
}
