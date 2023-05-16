import 'package:flutter/material.dart';

import '../../res/dimen/dimens.dart';
import '../app_icon_widget.dart';

class AddressAddWidget extends StatelessWidget {
  final VoidCallback onClick;

  const AddressAddWidget({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const Border(
        bottom: BorderSide(color: Colors.black26, width: 0.5),
      ),
      onTap: onClick,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIconWidget(
            codePoint: Icons.add.codePoint,
            defaultCodePoint: Icons.bookmark_border_outlined.codePoint,
            size: fontXL,
            color: Colors.black87,
          ),
        ],
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceSM),
        child: Text(
          'Thêm địa chỉ mới',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spaceSM,
      ),
      minVerticalPadding: 0,
      dense: true,
    );
  }
}
