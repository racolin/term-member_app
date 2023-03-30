import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

enum AlertType {
  error(Colors.orange, Colors.red),
  warning(Colors.orange, Colors.orange),
  empty(Colors.blue, Colors.black54);

  const AlertType(this.iconColor, this.textColor);

  final Color iconColor;
  final Color textColor;
}

class AlertPage extends StatelessWidget {
  final IconData icon;
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
          Icon(
            icon,
            size: icXXL,
            color: type.iconColor,
          ),
          const SizedBox(
            height: spaceLG,
          ),
          Text(
            description,
            style: TextStyle(
              color: type.textColor,
              fontSize: fontXL,
            ),
          )
        ],
      ),
    );
  }
}
