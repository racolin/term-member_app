import 'package:flutter/material.dart';

import '../../data/models/store_model.dart';
import '../res/dimen/dimens.dart';

class StoreItemWidget extends StatelessWidget {
  final Function(StoreShortModel) onClick;
  final StoreShortModel store;

  const StoreItemWidget({
    Key? key,
    required this.store,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: spaceXS,
        vertical: spaceXXS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          spaceXS,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(spaceXS),
        onTap: () {
          onClick(store);
        },
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(
            vertical: spaceXS,
            horizontal: 0,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: spaceXS,
            horizontal: spaceMD,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(spaceXS),
                child: Image.network(
                  store.image,
                  height: 72,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: spaceMD),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: fontMD,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: spaceXXS,
                      ),
                      Text(
                        store.fullAddress,
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: fontSM,
                        ),
                      ),
                      const Spacer(),
                      Text(store.distance),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
