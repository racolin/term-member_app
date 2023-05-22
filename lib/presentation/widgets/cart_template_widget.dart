import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/cubits/product_cubit.dart';
import 'package:member_app/data/models/cart_detail_model.dart';
import 'package:member_app/data/models/product_model.dart';
import 'package:member_app/exception/app_message.dart';

import '../dialogs/app_dialog.dart';
import 'app_image_widget.dart';
import '../../supports/convert.dart';
import '../../data/models/cart_template_model.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class CartTemplateWidget extends StatefulWidget {
  final CartTemplateModel cart;
  final VoidCallback? onClick;

  const CartTemplateWidget({
    Key? key,
    required this.cart,
    this.onClick,
  }) : super(key: key);

  @override
  State<CartTemplateWidget> createState() => _CartTemplateWidgetState();
}

class _CartTemplateWidgetState extends State<CartTemplateWidget> {
  List<ProductModel?> products = [];
  List<int> costs = [];

  @override
  void initState() {
    products = [];
    costs = [];
    for (var e in widget.cart.products) {
      var product = context.read<ProductCubit>().getProductById(e.id);
      products.add(product);
      costs.add(
        (product?.cost ?? 0) +
            getCostOptions(
              context,
              e.options,
            ),
      );
    }
    super.initState();
  }

  int getCostOptions(BuildContext context, List<String> options) {
    return context.read<ProductCubit>().getCostOptionsItem(
              options,
            ) ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            spaceXS,
          ),
        ),
        margin: const EdgeInsets.all(spaceXS),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: spaceSM,
            horizontal: spaceLG,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(
                height: spaceXS,
              ),
              for (var i = 0; i < products.length; i++)
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: AppImageWidget(
                    width: 36,
                    height: 36,
                    borderRadius: BorderRadius.circular(18),
                    assetsDefaultImage: assetDefaultIcon,
                    image: products[i]?.image,
                  ),
                  trailing: Text(numberToCurrency(costs[i], 'đ')),
                  title: Text(
                    '${widget.cart.products[i].amount} x ${products[i]?.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.cart.products[i].options
                        .map((e) => context
                            .read<ProductCubit>()
                            .getProductOptionItemById(e)
                            ?.name)
                        .join(', '),
                  ),
                ),
              Row(
                children: [
                  Text(
                    '$txtTotalCost: ${numberToCurrency(costs.fold(0, (pre, e) => pre + e), 'đ')}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      var clear = await showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            message: AppMessage(
                              type: AppMessageType.notify,
                              title: txtNotifyTitle,
                              content: 'Đơn hàng hiện tại của bạn sẽ bị xoá '
                                  'và được thay thế bằng đơn hàng mẫu này!',
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text(txtCancel),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text(txtConfirm),
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                              ),
                            ],
                          );
                        },
                      );
                      if (mounted) {
                        if (clear) {
                          var message =
                              await context.read<CartCubit>().addProductToCart(
                                    widget.cart.products
                                        .map(
                                          (e) => CartProductModel.fromMap(
                                            e.toMap(),
                                          ),
                                        )
                                        .toList(),
                                  );
                          if (mounted) {
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

                            }
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(txtOrderNow),
                        Icon(Icons.arrow_circle_right_outlined),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
