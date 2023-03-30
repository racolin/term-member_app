import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionName {
  final String name;
  final VoidCallback action;

  ActionName({
    required this.name,
    required this.action,
  });
}

class ErrorWidget extends StatelessWidget {
  final String title;
  final String content;
  final List<ActionName> actions;

  const ErrorWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions
          .map(
            (e) => TextButton(
              onPressed: e.action,
              child: Text(e.name),
            ),
          )
          .toList(),
    );
  }
}
