import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

class DragBarWidget extends StatelessWidget {
  final double margin;
  const DragBarWidget({Key? key, required this.margin,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(margin),
        width: dimSM,
        height: spaceXXS,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(spaceXXS / 2)
        ),
      ),
    );
  }
}
