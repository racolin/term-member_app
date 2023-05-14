import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppFaIconWidget extends StatelessWidget {
  final double size;
  final int? codePoint;
  final int defaultCodePoint;
  final Color? color;

  const AppFaIconWidget({
    Key? key,
    this.codePoint,
    this.defaultCodePoint = 0xea1b,
    required this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FaIcon(
      IconDataSolid(codePoint ?? defaultCodePoint),
      color: color ?? Colors.grey,
      size: size,
    );
  }
}
