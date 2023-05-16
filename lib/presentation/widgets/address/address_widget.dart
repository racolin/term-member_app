import 'package:flutter/material.dart';

import '../../../data/models/address_model.dart';
import '../../res/dimen/dimens.dart';
import '../app_fa_icon_widget.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel model;
  final VoidCallback onClick;

  const AddressWidget({
    Key? key,
    required this.model,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppFaIconWidget(
            codePoint: model.iconInt,
            defaultCodePoint: Icons.bookmark_border_outlined.codePoint,
            size: fontLG,
            color: Colors.black87,
          ),
        ],
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: spaceSM),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26, width: 0.5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: spaceXS,
            ),
            Text(
              model.address,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: spaceXXS,
            ),
            Text(
              '${model.receiver} ${model.phone}',
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
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
