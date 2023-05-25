import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/cubits/cart_template_cubit.dart';
import 'package:member_app/data/models/cart_template_model.dart';
import 'package:member_app/presentation/bottom_sheet/product_bottom_sheet.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../../business_logic/cubits/product_cubit.dart';
import '../../../data/models/cart_detail_model.dart';
import '../../../data/models/product_model.dart';
import '../../../supports/convert.dart';
import '../../res/dimen/dimens.dart';
import '../app_image_widget.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel model;
  final bool isTemplate;

  const ProductWidget({
    Key? key,
    required this.model,
    this.isTemplate = false,
  }) : super(key: key);

  final double height = 100;
  final double width = 120;

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
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(spaceXS),
              child: AppImageWidget(
                image: model.image,
                height: height,
                width: width,
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
                          model.name,
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
                          numberToCurrency(model.cost + costOptions, 'đ'),
                          style: const TextStyle(fontSize: fontMD),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            var options = <String>[];

                            for (var o in model.optionIds) {
                              var item = context
                                  .read<ProductCubit>()
                                  .getProductOptionById(o);
                              if (item != null) {
                                options.addAll(item.defaultSelect);
                              }
                            }

                            if (isTemplate) {
                              var message = context
                                  .read<CartTemplateCubit>()
                                  .addItemSelected(
                                    CartTemplateProductModel(
                                      id: model.id,
                                      amount: 1,
                                      options: options,
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
                                      'Thêm sản phẩm vào đơn hàng mẫu thành công',
                                    ),
                                  ),
                                );
                              }
                            } else {
                              var message =
                              context.read<CartCubit>().addProductToCart(
                                        CartProductModel(
                                          id: model.id,
                                          name: model.name,
                                          cost: model.cost,
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
                            }
                          },
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
