import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../supports/convert.dart';
import '../res/dimen/dimens.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel shortProduct;

  const ProductWidget({
    Key? key,
    required this.shortProduct,
  }) : super(key: key);

  final double height = 100;
  final double width = 120;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(spaceXS),
      overlayColor: MaterialStateProperty.all(
        Theme.of(context).primaryColor.withOpacity(
              opaXS,
            ),
      ),
      onTap: () {},
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(spaceXS),
              child: Image.network(
                shortProduct.image,
                height: height,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: spaceXXS,
                  horizontal: spaceXS,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shortProduct.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: fontMD,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: spaceXXS,
                        ),
                        Text(
                          numberToCurrency(shortProduct.price, 'đ'),
                          style: const TextStyle(fontSize: fontMD),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          splashRadius: spaceXL,
                          icon: const Icon(
                            Icons.add_circle_sharp,
                            color: Colors.deepOrangeAccent,
                            size: fontXXL,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
