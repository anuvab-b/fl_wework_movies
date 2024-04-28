import 'package:flutter/material.dart';

class CustomCardPainter extends CustomPainter {
  final BuildContext context;

  CustomCardPainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black.withOpacity(0.3);
    paint.style = PaintingStyle.fill;

    var path = Path();

    double scaleFactor = (MediaQuery.of(context).size.width - 2 * 16) / 7;
    double horizontalScaleFactor = scaleFactor;
    double verticalScaleFactor = 10;

    /// Square with round edges
    // path.lineTo(20,0);
    // path.lineTo(30,0);
    // path.quadraticBezierTo(40,0, 40,10);
    // // path.lineTo(40,10);
    // path.lineTo(40,30);
    // path.quadraticBezierTo(40,40,30,40);
    // path.lineTo(40,40);
    // path.lineTo(0,40);
    // // path.lineTo(20,20);

    path.moveTo(0, 10);
    /// Basic Custom Shape
    path.lineTo(0,10);
    path.lineTo(25,10);
    path.quadraticBezierTo(30,10,30,5);
    path.lineTo(30,5);
    path.quadraticBezierTo(30,0,35,0);
    path.lineTo(65,0);
    path.quadraticBezierTo(70,0,70,5);
    path.lineTo(70,10);
    path.quadraticBezierTo(70,15,65,15);
    path.quadraticBezierTo(60,15,60,20);
    path.lineTo(60,20);
    path.quadraticBezierTo(60,25,55,25);
    path.lineTo(5,25);
    path.quadraticBezierTo(0,25,0,20);
    path.lineTo(0,15);
    path.quadraticBezierTo(0,10,5,10);
    path.lineTo(5,10);
    canvas.drawPath(path, paint);

    path.moveTo(0, 10);

    /// Basic Custom Shape with scale factor
    // path.lineTo(0, scaleFactor);
    // path.lineTo(scaleFactor * 2.5, scaleFactor);
    // path.quadraticBezierTo(
    //     scaleFactor * 3, scaleFactor, scaleFactor * 3, scaleFactor / 2);
    // path.lineTo(scaleFactor * 3, scaleFactor / 2);
    // path.quadraticBezierTo(scaleFactor * 3, 0, scaleFactor * 3.5, 0);
    // path.lineTo(scaleFactor * 6.5, 0);
    // path.quadraticBezierTo(
    //     scaleFactor * 7, 0, scaleFactor * 7, scaleFactor / 2);
    // path.lineTo(scaleFactor * 7, scaleFactor * 1.0);
    // path.quadraticBezierTo(
    //     scaleFactor * 7, scaleFactor * 1.5, scaleFactor * 6.5, scaleFactor * 1.5);
    // path.quadraticBezierTo(
    //     scaleFactor * 6, scaleFactor * 1.5, scaleFactor * 6, scaleFactor * 2.0);
    // path.lineTo(scaleFactor * 6, scaleFactor * 2.0);
    // path.quadraticBezierTo(
    //     scaleFactor * 6, scaleFactor * 2.5, scaleFactor * 5.5, scaleFactor * 2.5);
    // path.lineTo(scaleFactor / 2, scaleFactor * 2.5);
    // path.quadraticBezierTo(0, scaleFactor * 2.5, 0, scaleFactor * 2.0);
    // path.lineTo(0, scaleFactor * 1.5);
    // path.quadraticBezierTo(0, scaleFactor, scaleFactor / 2, scaleFactor);
    // path.lineTo(scaleFactor / 2, scaleFactor);
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
