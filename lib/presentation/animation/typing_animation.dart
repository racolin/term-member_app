import 'dart:async';

import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

class TypingAnimation extends StatefulWidget {
  final Color backgroundColor;
  final Color color;
  final Color activeColor;
  final int milliseconds;
  final int amount;

  const TypingAnimation({
    Key? key,
    required this.backgroundColor,
    required this.color,
    required this.activeColor,
    this.amount = 3,
    this.milliseconds = 250,
  }) : super(key: key);

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation> {

  late Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: widget.milliseconds), (timer) {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimSM,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(spaceXXS),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: spaceXXS),
        height: fontXL,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(spaceXS),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < widget.amount; i++)
              Container(
                height: spaceXS,
                width: spaceXS,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spaceXXS),
                  color: timer.tick % widget.amount == i ? widget.activeColor : widget.color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
