import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exception/app_message.dart';
import '../../presentation/res/dimen/dimens.dart';

class AppDialog extends StatelessWidget {
  final AppMessage message;
  final List<CupertinoDialogAction> actions;

  const AppDialog({
    Key? key,
    required this.message,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = _getColor(message.type);
    return CupertinoAlertDialog(
      title: Text(
        message.title,
        style: TextStyle(
          color: color,
          fontSize: fontLG,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        message.content,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: fontMD,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: actions,
    );
  }

  Color _getColor(AppMessageType type) {
    switch (type) {
      case AppMessageType.error:
        return Colors.red;
      case AppMessageType.failure:
        return Colors.orange;
      case AppMessageType.success:
        return Colors.green;
      case AppMessageType.info:
        return Colors.blue;
      case AppMessageType.none:
        return Colors.grey;
    }
    return Colors.grey;
  }
}
