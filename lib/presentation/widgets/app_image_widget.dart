import 'package:flutter/material.dart';

class AppImageWidget extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const AppImageWidget({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: image == null
          ? Image.asset(
              'assets/images/image_default.png',
              height: height,
              width: width,
              fit: BoxFit.cover,
            )
          : Image.network(
              image!,
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
    );
  }
}
