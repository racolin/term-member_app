import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

class LabelField extends StatelessWidget {
  final String title;
  final bool isForce;

  const LabelField({
    Key? key,
    required this.title,
    required this.isForce,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: fontMD,
          fontWeight: FontWeight.w600,
        ),
        children: [
          if (isForce)
            const TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: fontMD,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
