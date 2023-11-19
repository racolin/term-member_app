import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/bottom_sheet/product_bottom_sheet.dart';

import '../../../business_logic/cubits/product_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../supports/convert.dart';
import '../../res/dimen/dimens.dart';
import '../app_image_widget.dart';

class ProductNormalWidget extends StatelessWidget {
  final ProductModel model;
  final bool isTemplate;

  const ProductNormalWidget({
    Key? key,
    required this.model,
    this.isTemplate = false,
  }) : super(key: key);

  final double imageHeight = 150;

  @override
  Widget build(BuildContext context) {
    int costOptions = context.read<ProductCubit>().getCostDefaultOptions(
              model.optionIds,
            ) ??
        0;
    return InkWell(
      borderRadius: BorderRadius.circular(spaceXS),
      overlayColor: MaterialStateProperty.all(
        Theme.of(context).primaryColor.withOpacity(
              opaXS,
            ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) {
            return BlocProvider<ProductCubit>.value(
              value: BlocProvider.of<ProductCubit>(context),
              child: ProductBottomSheet(product: model, isTemplate: isTemplate),
            );
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(spaceXS),
            child: AppImageWidget(
              image: model.image,
              height: imageHeight,
              width: double.maxFinite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: spaceXS,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontMD,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            numberToCurrency(model.cost + costOptions, 'đ'),
                            style: const TextStyle(fontSize: fontMD),
                          ),
                          // Text(
                          //   numberToCurrency(model.cost + costOptions, 'đ'),
                          //   style: const TextStyle(
                          //     fontSize: fontMD,
                          //     decoration: TextDecoration.lineThrough,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    IconButton(
                      // visualDensity: VisualDensity.comfortable,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) {
                            return BlocProvider<ProductCubit>.value(
                              value: BlocProvider.of<ProductCubit>(context),
                              child: ProductBottomSheet(
                                product: model,
                                isTemplate: isTemplate,
                              ),
                            );
                          },
                        );
                      },
                      splashRadius: spaceLG,
                      icon: const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.deepOrangeAccent,
                        size: dimXS,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
