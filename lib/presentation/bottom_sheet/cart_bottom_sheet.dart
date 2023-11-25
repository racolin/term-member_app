import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/data/models/pay_method_model.dart';
import 'package:member_app/data/models/voucher_model.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/cubits/voucher_cubit.dart';
import '../../business_logic/repositories/voucher_repository.dart';
import '../../business_logic/states/cart_state.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/api/voucher_api_repository.dart';
import '../../exception/app_message.dart';
import '../../supports/convert.dart';
import '../res/dimen/dimens.dart';
import '../screens/product_search_screen.dart';
import '../screens/voucher_screen.dart';
import '../widgets/product/products_suggest_widget.dart';
import 'pay_method_bottom_sheet.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({Key? key}) : super(key: key);

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartInitial:
            return const SizedBox();
          case CartLoading:
            return const LoadingPage();
          case CartLoaded:
            state as CartLoaded;
            return Container(
              margin: const EdgeInsets.only(top: 56),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getTitle(context),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 76,
                                  child: Row(
                                    children: [
                                      if (state.categoryId ==
                                          DeliveryType.delivery) ...[
                                        Expanded(
                                          child: _getInfoItem(
                                            state.receiver ?? txtUnknown,
                                            state.phone ?? txtUnknown,
                                            () {},
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          width: 1,
                                          color: Colors.grey.withAlpha(100),
                                          height: 56,
                                        ),
                                        const SizedBox(width: 12),
                                      ],
                                      Expanded(
                                        child: _getInfoItem(
                                          dateToString(
                                              state.time ?? DateTime.now(),
                                              'dd/MM'),
                                          'Càng sớm càng tốt',
                                          () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _getProducts(context, state.products),
                          const SizedBox(height: 8),
                          _getTotal(
                            costs.fold(0, (p, e) => p + e),
                            (state.categoryId == DeliveryType.takeOut) ? 0 : state.fee,
                            state.voucherDiscount,
                            state.voucher?.name ?? '',
                          ),
                          const SizedBox(height: 8),
                          const ProductsSuggestWidget(
                            height: 307,
                          ),
                          const SizedBox(height: 8),
                          _getMethod(state.categoryId),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  _getOrderField(
                    state.categoryId?.name ?? '',
                    state.amount,
                    costs.fold(0, (p, e) => p + e) +
                        state.fee -
                        state.voucherDiscount,
                    // state.calculateCost,
                  ),
                ],
              ),
            );
        }
        return const SizedBox();
      },
    );
  }

  Widget _getInfoItem(String name, String content,
      [VoidCallback? onClick, Icon? icon]) {
    Widget item = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: fontSM,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: spaceXXS),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: spaceXXS),
            ],
            Text(
              content,
              style: const TextStyle(
                fontSize: fontMD,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
    if (onClick != null) {
      item = InkWell(
        onTap: onClick,
        child: Ink(
          child: item,
        ),
      );
    }
    return item;
  }

  Widget _getTitle(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 55,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: const Text(
                'Xác nhận đơn hàng',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close_sharp,
                  size: 22,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              top: 19,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  context.read<CartCubit>().clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Xoá',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _getProducts(
    BuildContext context,
    List<CartProductModel> products,
  ) {
    setup(products);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Sản phẩm đã chọn',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.orange.withAlpha(30),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return BlocProvider<IntervalBloc<ProductModel>>(
                        create: (ctx) => IntervalBloc<ProductModel>(
                          submit: BlocProvider.of<ProductCubit>(ctx),
                        ),
                        child: const ProductSearchScreen(
                          withFloatingButton: false,
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Text(
                '+ Thêm',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          for (int i = 0; i < products.length; i++) ...[
            GestureDetector(
              onTap: () {},
              child: Slidable(
                key: ValueKey(i),
                endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: const ScrollMotion(),
                  children: [
                    CustomSlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: null,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 12,
                          right: 6,
                          top: 2,
                          bottom: 2,
                        ),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_note_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'SỬA',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomSlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: (context) async {
                        var message = await context.read<CartCubit>().deleteProduct(
                              products[i],
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
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        width: double.maxFinite,
                        child: Container(
                          margin: const EdgeInsets.only(left: 6, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                'XOÁ',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(child: _getProduct(products[i], costs[i])),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_double_arrow_left,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: spaceSM),
            const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  List<int> costs = [];

  void setup(List<CartProductModel> products) {
    costs = [];
    for (var e in products) {
      var product = context.read<ProductCubit>().getProductById(e.id);
      if (product != null) {
        costs.add(
          (product.cost +
                  getCostOptions(
                    context,
                    e.options,
                  )) *
              e.amount,
        );
      }
    }
  }

  int getCostOptions(BuildContext context, List<String> options) {
    return context.read<ProductCubit>().getCostOptionsItem(
              options,
            ) ??
        0;
  }

  Widget _getProduct(CartProductModel model, int cost) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: Text(
        model.amount.toString(),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: fontMD,
            ),
      ),
      title: Text(
        model.name,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: fontMD,
            ),
      ),
      subtitle: Text(model.options
          .map((e) =>
              context.read<ProductCubit>().getProductOptionItemById(e)?.name)
          .join(', ')),
      trailing: Text(
        numberToCurrency(cost, 'đ'),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 14,
            ),
      ),
    );
  }

  Widget _getTotal(
    int total,
    int fee,
    int voucherDiscount,
    String voucherName,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              'Tổng cộng',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Thành tiền'),
              Text(numberToCurrency(total, 'đ'))
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phí vận chuyển'),
              Text(numberToCurrency(fee, 'đ')),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          InkWell(
            onTap: () async {
              var model = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return RepositoryProvider<VoucherRepository>(
                      create: (context) => VoucherApiRepository(),
                      child: BlocProvider<VoucherCubit>(
                        create: (context) => VoucherCubit(
                          repository: RepositoryProvider.of<VoucherRepository>(
                            context,
                          ),
                        ),
                        child: const VoucherScreen(returnable: true),
                      ),
                    );
                  },
                ),
              );
              if (mounted) {
                if (model != null && model is VoucherModel) {
                  var message =
                      await context.read<CartCubit>().checkAndSetVoucher(model);
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
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            message: AppMessage(
                              type: AppMessageType.success,
                              title: txtSuccessTitle,
                              content: 'Áp dụng khuyến mãi thành công!',
                            ),
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
                    }
                  }
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chọn khuyến mãi',
                        style: TextStyle(color: Colors.blue),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: spaceXXS),
                  if (voucherDiscount != 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          voucherName,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          numberToCurrency(-voucherDiscount, 'đ'),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(bottom: spaceXS),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Số tiền thanh toán',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  numberToCurrency(total + fee - voucherDiscount, 'đ'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  late PayMethod _pay = PayMethod(
    name: 'Momo',
    type: PayMethodType.momo,
    image: 'https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png',
  );

  Widget _getMethod(DeliveryType? type) {
    return InkWell(
      onTap: () async {
        var pay = await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => PayMethodBottomSheet(
            deliveryType: type,selected: _pay.type,
          ),
        );
        if (pay is PayMethod) {
          setState(() {
            _pay = pay;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'Thanh toán',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  _pay.image,
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Text(_pay.name),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _getOrderField(
    String type,
    int amount,
    int cost,
  ) {
    return Container(
      height: 96,
      color: Colors.orange,
      child: ListTile(
        title: Text(
          '$type | $amount $txtProduct',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          numberToCurrency(cost, 'đ'),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            var message = await context.read<CartCubit>().create();

            if (mounted) {
              if (message == null) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Đặt hàng thành công!',
                    ),
                  ),
                );
              } else {
                Navigator.pop(context);
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
              }
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          child: Text(
            txtOrderNow.toUpperCase(),
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
