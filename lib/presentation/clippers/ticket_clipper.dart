import 'package:flutter/widgets.dart';
import 'dart:math';

class TicketClipper extends CustomClipper<Path> {
  final int numberOfSmall;
  final double ticketRate;

  TicketClipper({required this.numberOfSmall, required this.ticketRate});

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    var x = size.width;
    var y = size.height;
    var path = Path();

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, x, y),
        const Radius.circular(8),
      ),
    );

    var r = x / 40;

    var rMin = r / 2;

    var space = (y - r) / (numberOfSmall + 1);

    var init = r / 2 - rMin / 2;

    var clipPath = Path();

    clipPath.addArc(Rect.fromLTWH(x * ticketRate, -r / 2, r, r), 0, 2 * pi);

    clipPath.addArc(Rect.fromLTWH(x * ticketRate, y - r / 2, r, r), 0, 2 * pi);

    for (int i = 0; i < numberOfSmall; i++) {
      init += space;
      clipPath.addArc(
        Rect.fromLTWH(x * ticketRate + r / 2 - rMin / 2, init, rMin, rMin),
        0,
        2 * pi,
      );
    }

    return Path.combine(PathOperation.reverseDifference, clipPath, path);
  }
}
