import 'package:flutter/material.dart';

class AnimationPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimationPageRoute({required this.widget})
      : super(
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget;
            });
}
