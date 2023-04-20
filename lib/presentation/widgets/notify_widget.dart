import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';

import '../../data/models/notify_model.dart';
import '../../supports/convert.dart';
import '../bottom_sheet/notify_bottom_sheet.dart';

class NotifyWidget extends StatelessWidget {
  final NotifyModel notify;

  const NotifyWidget({
    Key? key,
    required this.notify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var result = await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => NotifyBottomSheet(
            notify: notify,
          ),
        );
        if (result is bool && result) {
          // ...
        }
      },
      child: Column(
        children: [
          Container(
            color: notify.checked ? Colors.white : Theme.of(context).primaryColor.withAlpha(20),
            padding: const EdgeInsets.only(
              top: spaceMD,
              bottom: spaceMD,
              right: spaceSM,
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: spaceXXS),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: spaceXXS, right: spaceSM),
                      width: spaceXXS,
                      height: spaceXXS,
                      decoration: !notify.checked
                          ? BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(spaceXXS / 2),
                            )
                          : null,
                    ),
                    AppImageWidget(
                      image: notify.image,
                      height: dimSM,
                      width: dimSM,
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                  ],
                ),
                const SizedBox(width: spaceMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notify.name,
                              style: const TextStyle(
                                fontSize: fontMD,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: spaceMD),
                          Text(
                            dateToString(notify.time, 'dd/MM'),
                            style: const TextStyle(fontSize: fontMD),
                          ),
                        ],
                      ),
                      Text(
                        notify.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(height: 1.25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
