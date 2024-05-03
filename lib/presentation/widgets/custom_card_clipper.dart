import 'package:flutter/material.dart';

class CustomCardClipper extends CustomClipper<Path> {
  final double scaleFactor;
  final double height;

  CustomCardClipper({required this.scaleFactor,this.height = 0.0});

  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, scaleFactor);

    /// Basic Custom Shape

    path.lineTo(0, scaleFactor);
    path.lineTo(scaleFactor * 2.5, scaleFactor);
    path.quadraticBezierTo(
        scaleFactor * 3, scaleFactor, scaleFactor * 3, scaleFactor / 2);
    path.lineTo(scaleFactor * 3, scaleFactor / 2);
    path.quadraticBezierTo(scaleFactor * 3, 0, scaleFactor * 3.5, 0);
    path.lineTo(scaleFactor * 6.5, 0);
    path.quadraticBezierTo(
        scaleFactor * 7, 0, scaleFactor * 7, scaleFactor / 2);
    path.lineTo(scaleFactor * 7, scaleFactor * 1.0);
    path.quadraticBezierTo(scaleFactor * 7, scaleFactor * 1.5,
        scaleFactor * 6.5, scaleFactor * 1.5);
    path.quadraticBezierTo(
        scaleFactor * 6, scaleFactor * 1.5, scaleFactor * 6, scaleFactor * 2.0);
    path.lineTo(scaleFactor * 6, scaleFactor * 2.0 + height);
    path.quadraticBezierTo(scaleFactor * 6, scaleFactor * 2.5 + height,
        scaleFactor * 5.5, scaleFactor * 2.5 + height);
    path.lineTo(scaleFactor / 2, scaleFactor * 2.5 + height);
    path.quadraticBezierTo(0, scaleFactor * 2.5  + height, 0, scaleFactor * 2.0 + height);
    path.lineTo(0, scaleFactor * 1.5);
    path.quadraticBezierTo(0, scaleFactor, scaleFactor / 2, scaleFactor);
    path.lineTo(scaleFactor / 2, scaleFactor);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}