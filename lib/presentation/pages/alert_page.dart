import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

enum AlertType {
  error(Colors.red),
  warning(Colors.orange),
  empty(Colors.blue);

  const AlertType(this.textColor);

  final Color textColor;
}

class AlertPage extends StatelessWidget {
  final Widget icon;
  final String description;
  final AlertType type;
  // final String actionName;
  // final VoidCallback action;

  const AlertPage({
    Key? key,
    required this.icon,
    required this.type,
    required this.description,
    // required this.action,
    // required this.actionName,
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
                fontWeight: FontWeight.w600),
          ),
          // ElevatedButton(
          //   onPressed: action,
          //   child: Text(actionName),
          // ),
        ],
      ),
    );
  }
}
