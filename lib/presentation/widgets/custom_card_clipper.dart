import 'package:flutter/material.dart';

class CustomCardClipper extends CustomClipper<Path> {
  final BuildContext context;

  CustomCardClipper({required this.context});

  @override
  Path getClip(Size size) {
    var path = Path();

    double scaleFactor = (MediaQuery.of(context).size.width - 2 * 16) / 7;

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
    path.lineTo(scaleFactor * 7, scaleFactor * 1.5);
    path.quadraticBezierTo(
        scaleFactor * 7, scaleFactor * 2, scaleFactor * 6.5, scaleFactor * 2);
    path.quadraticBezierTo(
        scaleFactor * 6, scaleFactor * 2, scaleFactor * 6, scaleFactor * 2.5);
    path.lineTo(scaleFactor * 6, scaleFactor * 3.5);
    path.quadraticBezierTo(
        scaleFactor * 6, scaleFactor * 4, scaleFactor * 5.5, scaleFactor * 4);
    path.lineTo(scaleFactor / 2, scaleFactor * 4);
    path.quadraticBezierTo(0, scaleFactor * 4, 0, scaleFactor * 3.5);
    path.lineTo(0, scaleFactor * 1.5);
    path.quadraticBezierTo(0, scaleFactor, scaleFactor / 2, scaleFactor);
    path.lineTo(scaleFactor / 2, scaleFactor);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}