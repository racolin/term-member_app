import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../data/models/product_model.dart';
import '../../supports/convert.dart';

class ProductSuggestWidget extends StatelessWidget {
  final ProductModel product;

  const ProductSuggestWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceXS),
      width: dimXXL * 1.2,
      height: 268,
      child: GestureDetector(
        onTap: () {
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(spaceXS),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(
              height: spaceXS,
            ),
            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              height: fontSM,
            ),
            Text(numberToCurrency(product.price, 'đ')),
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                onPressed: () {
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: const Text(
                  txtSelect,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
