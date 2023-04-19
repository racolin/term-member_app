import 'package:flutter/material.dart';

class DeliveryOptionWidget extends StatelessWidget {
  final double height;
  final String name;
  final String image;
  final VoidCallback onClick;

  const DeliveryOptionWidget({
    Key? key,
    required this.height,
    required this.name,
    required this.image,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(height * 0.25),
              child: Image.asset(
                image,
                width: height * 0.5,
                height: height * 0.5,
                fit: BoxFit.cover,
              ),
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
