import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../business_logic/app_message.dart';
import '../../presentation/dialogs/message_notify_type.dart';
import '../../presentation/res/dimen/dimens.dart';

class DialogWidget extends StatelessWidget {
  final MessageNotify messageNotify;
  final List<CupertinoDialogAction> actions;

  const DialogWidget({
    Key? key,
    required this.messageNotify,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = _getColor(messageNotify.messageType);
    return CupertinoAlertDialog(
      title: Text(
        messageNotify.title,
        style: TextStyle(
          color: color,
          fontSize: fontLG,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        messageNotify.content,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: fontMD,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: actions,
    );
  }

  Color _getColor(MessageType type) {
    switch (type) {
      case MessageType.error:
        return Colors.red;
      case MessageType.failure:
        return Colors.orange;
      case MessageType.success:
        return Colors.green;
      case MessageType.info:
        return Colors.blue;
      case MessageType.none:
        return Colors.grey;
    }
    return Colors.grey;
  }
}
