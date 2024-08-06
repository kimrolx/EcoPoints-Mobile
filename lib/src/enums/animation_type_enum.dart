import 'package:flutter/material.dart';

enum AnimationType {
  slideRight,
  slideLeft,
  fadeIn,
  fadeOut,
  scale,
  slideUp,
  slideDown,
}

Widget buildPageTransition({
  required Widget child,
  required Animation<double> animation,
  required AnimationType type,
  Curve curve = Curves.easeInOut,
}) {
  Animation<double> curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  switch (type) {
    case AnimationType.slideRight:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );
    case AnimationType.slideLeft:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );
    case AnimationType.fadeIn:
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        child: child,
      );
    case AnimationType.fadeOut:
      return FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(curvedAnimation),
        child: child,
      );
    case AnimationType.scale:
      return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        child: child,
      );
    case AnimationType.slideUp:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );
    case AnimationType.slideDown:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    default:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
  }
}
