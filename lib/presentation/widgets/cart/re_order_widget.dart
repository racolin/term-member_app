import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/cart_detail_model.dart';
import 'package:member_app/data/models/product_model.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/bottom_sheet/cart_bottom_sheet.dart';

import '../../../business_logic/cubits/cart_cubit.dart';
import '../../../business_logic/cubits/product_cubit.dart';
import '../../../supports/convert.dart';
import '../../dialogs/app_dialog.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';
import '../app_image_widget.dart';

class ReOrderWidget extends StatefulWidget {
  final CartDetailModel cart;
  final VoidCallback? onClick;

  const ReOrderWidget({
    Key? key,
    required this.cart,
    this.onClick,
  }) : super(key: key);

  @override
  State<ReOrderWidget> createState() => _ReOrderWidgetState();
}

class _ReOrderWidgetState extends State<ReOrderWidget> {
  List<ProductModel?> products = [];
  List<int> costs = [];
  List<int> amounts = [];

  @override
  void didUpdateWidget(covariant ReOrderWidget oldWidget) {
    updateModel(context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    updateModel(context);
    super.initState();
  }

  void updateModel(BuildContext context) {
    products = [];
    costs = [];
    amounts = [];
    for (var e in widget.cart.products) {
      var product = context.read<ProductCubit>().getProductById(e.id);
      products.add(product);
      amounts.add(e.amount);
      costs.add(
        ((product?.cost ?? 0) +
                getCostOptions(
                  context,
                  e.options,
                )) *
            e.amount,
      );
    }
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
                                  'và được thay thế bằng đơn hàng này!',
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
                          List<CartProductModel> list = [];
                          for (var e in widget.cart.products) {
                            var p = context
                                .read<ProductCubit>()
                                .getProductById(e.id);
                            if (p != null) {
                              list.add(CartProductModel(
                                id: e.id,
                                name: p.name,
                                cost: p.cost,
                                options: e.options,
                                amount: e.amount,
                                note: '',
                              ));
                            }
                          }

                          var message =
                              context.read<CartCubit>().addProductsToCart(
                                    list,
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
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (ctx) {
                                  return const CartBottomSheet();
                                },
                              );
                            }
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.orange,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          txtReOrder,
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
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
