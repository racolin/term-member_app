import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  final double size;
  final int? codePoint;
  final int defaultCodePoint;
  final Color? color;

  const AppIconWidget({
    Key? key,
    this.codePoint,
    this.defaultCodePoint = 0xea1b,
    required this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(
        codePoint ?? defaultCodePoint,
        fontFamily: 'MaterialIcons',
      ),
      color: color ?? Colors.grey,
      size: size,
    );
  }
}
