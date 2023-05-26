import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';

import '../../../business_logic/cubits/cart_cubit.dart';
import '../../../business_logic/cubits/product_cubit.dart';
import '../../../data/models/cart_detail_model.dart';
import '../../../data/models/product_model.dart';
import '../../../supports/convert.dart';
import '../../bottom_sheet/product_bottom_sheet.dart';
import '../../dialogs/app_dialog.dart';

class ProductSuggestWidget extends StatelessWidget {
  final ProductModel product;

  const ProductSuggestWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int costOptions = context.read<ProductCubit>().getCostDefaultOptions(
      product.optionIds,
    ) ?? 0;
    return Container(
      padding: const EdgeInsets.all(spaceXS),
      width: dimXXL * 1.2,
      height: 268,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) {
              return BlocProvider<ProductCubit>.value(
                value: BlocProvider.of<ProductCubit>(context),
                child: ProductBottomSheet(product: product),
              );
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(spaceXS),
              child: AppImageWidget(
                image: product.image,
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
            Text(numberToCurrency(product.cost + costOptions, 'đ')),
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                onPressed: () {
                  var options = <String>[];

                  for (var o in product.optionIds) {
                    var item = context
                        .read<ProductCubit>()
                        .getProductOptionById(o);
                    if (item != null) {
                      options.addAll(item.defaultSelect);
                    }
                  }
                  var message =
                  context.read<CartCubit>().addProductToCart(
                    CartProductModel(
                      id: product.id,
                      name: product.name,
                      cost: product.cost,
                      options: options,
                      amount: 1,
                      note: '',
                    ),
                  );
                  if (message != null) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return AppDialog(
                          message: message,
                          actions: [
                            CupertinoDialogAction(
                              child: const Text(txtConfirm),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Thêm sản phẩm vào đơn hàng thành công',
                        ),
                      ),
                    );
                  }
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
