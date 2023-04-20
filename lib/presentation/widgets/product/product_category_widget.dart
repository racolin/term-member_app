import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';

import '../../../data/models/product_category_model.dart';

class ProductCategoryWidget extends StatelessWidget {
  final ProductCategoryModel? category;

  const ProductCategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppImageWidget(
          height: 2 * spaceXL,
          width: 2 * spaceXL,
          image: category?.image,
          borderRadius: BorderRadius.circular(spaceXL),
          assetsDefaultImage: 'assets/images/image_more.jpeg',
          imageBuilder: (ctx, provider) {
            return CircleAvatar(
              radius: spaceXL,
              backgroundImage: provider,
            );
          },
        ),
        const SizedBox(
          height: spaceXXS,
        ),
        Text(
          category?.name ?? 'Xem thêm',
          style: const TextStyle(fontSize: fontXS),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
