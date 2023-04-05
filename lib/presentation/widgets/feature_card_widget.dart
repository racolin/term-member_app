import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

class FeatureCardWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onClick;

  const FeatureCardWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(spaceXS),
      ),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor.withOpacity(opaSM),
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor.withOpacity(opaSM),
        ),
        borderRadius: BorderRadius.circular(spaceXS),
        onTap: onClick,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(spaceXS),
          ),
          padding: const EdgeInsets.all(spaceMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: fontXL),
              const SizedBox(
                height: spaceXS,
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}