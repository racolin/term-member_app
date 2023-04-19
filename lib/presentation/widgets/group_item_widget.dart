import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

class GroupItemWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onClick;
  final bool isTop;
  final bool isBottom;

  const GroupItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
    this.isTop = false,
    this.isBottom = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(
        Theme.of(context).primaryColor.withOpacity(opaSM),
      ),
      borderRadius: BorderRadius.vertical(
        bottom: isBottom ? const Radius.circular(spaceXS) : Radius.zero,
        top: isTop ? const Radius.circular(spaceXS) : Radius.zero,
      ),
      onTap: onClick,
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(fontSize: fontMD),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
          size: fontLG,
        ),
      ),
    );
  }
}
