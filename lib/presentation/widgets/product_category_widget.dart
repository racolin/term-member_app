import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../data/models/product_category_model.dart';

class ProductCategoryWidget extends StatelessWidget {
  final ProductCategoryModel category;

  const ProductCategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: spaceXL,
          backgroundImage: NetworkImage(category.image),
        ),
        const SizedBox(
          height: spaceXXS,
        ),
        Text(
          category.name,
          style: const TextStyle(fontSize: fontXS),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
