import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/promotion_cubit.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../../business_logic/cubits/voucher_cubit.dart';
import '../../../data/models/promotion_model.dart';
import '../../bottom_sheet/promotion_bottom_sheet.dart';
import '../../res/dimen/dimens.dart';
import '../app_image_widget.dart';

class PromotionMeWidget extends StatelessWidget {
  final PromotionModel promotion;
  final double size = 160;

  const PromotionMeWidget({
    Key? key,
    required this.promotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              updateVoucher: () {
                context.read<VoucherCubit>().loadAvailableVouchers();
              },
            );
          },
        );
      },
      child: SizedBox(
        width: size,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: spaceXXS),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(spaceXS),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(spaceXS),
                ),
                child: AppImageWidget(
                  image: promotion.backgroundImage,
                  height: size,
                  width: size,
                ),
              ),
              const SizedBox(
                height: spaceXS,
              ),
              const CircleAvatar(
                radius: spaceSM,
                child: AppImageWidget(
                  image: 'https://cdn-icons-png.flaticon.com/512/680/680391.png',
                ),
              ),
              const SizedBox(
                height: spaceXS,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: spaceXS),
                child: SizedBox(
                  height: 36,
                  child: Text(
                    promotion.description,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: fontMD,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: spaceXS,
              ),
              IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: spaceMD, vertical: spaceXXS),
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
              ),
              const SizedBox(
                height: spaceXS,
              ),
              const Text(
                txtPointName,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: spaceXS,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
