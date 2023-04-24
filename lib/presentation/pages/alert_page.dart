import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

enum AlertType {
  error(Colors.orange),
  warning(Colors.orange),
  empty(Colors.blue);

  const AlertType(this.textColor);

  final Color textColor;
}

class AlertPage extends StatelessWidget {
  final Widget icon;
  final String description;
  final AlertType type;

  const AlertPage({
    Key? key,
    required this.icon,
    required this.type,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            height: spaceLG,
          ),
          Text(
            description,
            style: TextStyle(
              color: type.textColor,
              fontSize: fontXL,
              fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}
