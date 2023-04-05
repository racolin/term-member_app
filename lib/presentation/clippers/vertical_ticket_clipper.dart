import 'package:flutter/widgets.dart';
import 'dart:math';

class VerticalTicketClipper extends CustomClipper<Path> {
  final int numberOfSmall;

  VerticalTicketClipper({required this.numberOfSmall,});

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    var x = size.width;
    var y = size.height;

    var r = 8.0;

    var rMin = r / 2;

    var space = (x - r) / (numberOfSmall + 1);

    var init = r / 2 - rMin / 2;

    var clipPath = Path();

    clipPath.addArc(Rect.fromLTWH(-r / 2, y / 2 - r / 2, r, r), 0, 2 * pi);

    clipPath.addArc(Rect.fromLTWH(x - r / 2, y / 2 - r / 2, r, r), 0, 2 * pi);

    for (int i = 0; i < numberOfSmall; i++) {
      init += space;
      clipPath.addArc(
        Rect.fromLTWH(init, y / 2 - rMin / 2, rMin, rMin),
        0,
        2 * pi,
      );
    }

    return clipPath;
  }
}
