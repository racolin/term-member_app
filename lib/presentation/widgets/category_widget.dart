import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../data/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryWidget({
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
