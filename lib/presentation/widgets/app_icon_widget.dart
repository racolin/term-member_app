import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  final double size;
  final int? codePoint;
  final Color? color;

  const AppIconWidget({
    Key? key,
    this.codePoint,
    required this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(codePoint ?? 0xea1b),
      color: color ?? Colors.grey,
      size: size,
    );
  }
}
