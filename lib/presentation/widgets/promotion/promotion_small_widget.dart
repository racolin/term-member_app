import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';

import '../../../business_logic/cubits/promotion_cubit.dart';
import '../../../data/models/promotion_model.dart';
import '../../bottom_sheet/promotion_bottom_sheet.dart';

class PromotionSmallWidget extends StatelessWidget {
  final PromotionModel promotion;

  const PromotionSmallWidget({
    Key? key,
    required this.promotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(spaceXS),
      overlayColor: MaterialStateProperty.all(
        Theme.of(context).primaryColor.withOpacity(opaXS),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) {
            return PromotionBottomSheet(
              promotion: promotion,
              exchange: () {
                return context.read<PromotionCubit>().exchange(
                      promotion.id,
                    );
              },
            );
          },
        );
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: spaceXS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(spaceXS),
          color: Colors.white,
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(spaceXS),
            child: AppImageWidget(
              image: promotion.backgroundImage,
              assetsDefaultImage: assetDefaultImage,
              height: dimXL,
              width: dimMD,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: spaceXXS),
            child: Text(
              promotion.partner,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: fontMD,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          subtitle: Text(
            promotion.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: fontSM,
            ),
          ),
          trailing: Column(
            children: [
              Container(
                width: dimMD,
                padding: const EdgeInsets.all(spaceXXS),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(spaceMD),
                ),
                child: Text(
                  promotion.point.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: spaceXS,
              ),
              const Text(
                txtPointName,
                style: TextStyle(
                  color: Colors.black87,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
