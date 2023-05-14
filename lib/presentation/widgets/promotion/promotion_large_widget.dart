import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/promotion_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../../business_logic/cubits/promotion_cubit.dart';
import '../../bottom_sheet/promotion_bottom_sheet.dart';
import '../../res/dimen/dimens.dart';
import '../app_image_widget.dart';

class PromotionLargeWidget extends StatelessWidget {
  final PromotionModel promotion;
  final double size = 280;

  const PromotionLargeWidget({
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
            );
          },
        );
      },
      child: SizedBox(
        width: size,
        child: Card(
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
                  image: promotion.partnerImage,
                  height: size,
                  width: size,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(spaceMD),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            promotion.partner,
                            style: const TextStyle(
                              fontSize: fontMD,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: spaceXXS,
                          ),
                          SizedBox(
                            height: 36,
                            child: Text(
                              promotion.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: fontMD,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
