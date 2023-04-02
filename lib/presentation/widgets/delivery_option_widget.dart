import 'package:flutter/material.dart';

class DeliveryOptionWidget extends StatefulWidget {
  final double height;
  final String name;
  final String image;

  const DeliveryOptionWidget({
    Key? key,
    required this.height,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  State<DeliveryOptionWidget> createState() => _DeliveryOptionWidgetState();
}

class _DeliveryOptionWidgetState extends State<DeliveryOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            widget.image,
            width: widget.height * 0.5,
            height: widget.height * 0.5,
            fit: BoxFit.cover,
          ),
          Text(widget.name),
        ],
      ),
    );
  }
}
