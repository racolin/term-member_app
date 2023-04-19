import 'package:flutter/material.dart';

import '../../../data/models/product_option_model.dart';

class ProductOptionWidget extends StatelessWidget {
  final ProductOptionModel model;
  final Function(String) onPress;

  const ProductOptionWidget({
    Key? key,
    required this.model,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.minSelected > 0) {}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }

  Widget _getItem(ProductOptionItemModel item, bool initValue, bool isCheckBox) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Checkbox(value: initValue, onChanged: item.disable ? null : () {}),
        Text(item.name)
      ],
    );
  }
}
