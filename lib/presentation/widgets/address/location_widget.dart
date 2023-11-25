import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';
import 'package:member_app/supports/convert.dart';

import '../../../business_logic/cubits/address_cubit.dart';

class LocationWidget extends StatelessWidget {
  final AddressEntity model;
  final LatLng? root;
  final VoidCallback onClick;

  const LocationWidget({
    Key? key,
    required this.model,
    this.root,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(model.toMap());
    var distance = model.meters ?? 0;
    if (model.meters == null) {
      var latLngAddress = LatLng(model.lat!, model.lng!);
      distance = positionToDistance(
        root!.latitude,
        root!.longitude,
        latLngAddress.latitude,
        latLngAddress.longitude,
      );
    }
    return InkWell(
      onTap: onClick,
      child: Ink(
        color: Colors.white,
        padding: const EdgeInsets.all(spaceSM),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: spaceXS, right: spaceLG),
              child: model.icon == null
                  ? const Icon(
                      Icons.location_on_rounded,
                      size: fontXL,
                      color: Colors.orange,
                    )
                  : AppImageWidget(
                      image: model.icon,
                      height: fontXL,
                      width: fontXL,
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontMD,
                    ),
                  ),
                  const SizedBox(height: spaceXXS),
                  if (model.address != null)
                    Text(
                      model.address!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: fontSM,
                      ),
                    ),
                  const SizedBox(height: spaceXXS),
                  Text(
                    meterToString(distance),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: fontSM,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
