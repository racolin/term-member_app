import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/data/models/pay_method_model.dart';
import 'package:member_app/data/models/voucher_model.dart';
import 'package:member_app/presentation/bottom_sheet/product_edit_bottom_sheet.dart';
import 'package:member_app/presentation/bottom_sheet/receiver_bottom_sheet.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/cart_detail_cubit.dart';
import '../../business_logic/cubits/carts_cubit.dart';
import '../../business_logic/cubits/geolocator_cubit.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/cubits/store_cubit.dart';
import '../../business_logic/cubits/voucher_cubit.dart';
import '../../business_logic/repositories/cart_repository.dart';
import '../../business_logic/repositories/store_repository.dart';
import '../../business_logic/repositories/voucher_repository.dart';
import '../../business_logic/states/cart_state.dart';
import '../../data/models/address_model.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/response_model.dart';
import '../../data/models/store_model.dart';
import '../../data/repositories/api/store_api_repository.dart';
import '../../data/repositories/api/voucher_api_repository.dart';
import '../../exception/app_message.dart';
import '../../supports/convert.dart';
import '../app_router.dart';
import '../res/dimen/dimens.dart';
import '../screens/cart/cart_detail_screen.dart';
import '../screens/product_search_screen.dart';
import '../screens/store_search_screen.dart';
import '../screens/voucher_screen.dart';
import '../widgets/product/products_suggest_widget.dart';
import 'method_order_bottom_sheet.dart';
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
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Loại đơn: ${state.categoryId == DeliveryType.takeOut ? txtOptionTake : txtOptionDelivery}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.orange.withAlpha(30),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        // padding: MaterialStateProperty.all(EdgeInsets.zero),
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16),
                                            ),
                                          ),
                                          builder: (ctx) =>
                                              MethodOrderBottomSheet(
                                            type: state.categoryId,
                                            addressName: state.addressName,
                                            login: true,
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Thay đổi',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                ListTile(
                                  onTap: () {
                                    if (state.categoryId ==
                                        DeliveryType.delivery) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouter.addressSearch,
                                      ).then((value) {
                                        if (value == null ||
                                            value is! AddressModel) {
                                          showCupertinoDialog(
                                            context: context,
                                            builder: (context) {
                                              return AppDialog(
                                                message: AppMessage(
                                                  type: AppMessageType.failure,
                                                  title: txtFailureTitle,
                                                  content:
                                                      'Không có địa chỉ nào được trả về.',
                                                ),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child:
                                                        const Text(txtConfirm),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          return;
                                        }
                                        var address = value;
                                        context
                                            .read<CartCubit>()
                                            .setCategory(2);
                                        context
                                            .read<ProductCubit>()
                                            .clearUnavailable();
                                        context.read<CartCubit>().setPayType(1);
                                        context.read<CartCubit>().setReceiver(
                                              address.receiver,
                                              address.phone,
                                            );
                                        context.read<CartCubit>().setAddress(
                                              address.address.split('||').last,
                                              '${address.receiver} ${address.name}',
                                              address.lat ?? 10.45,
                                              address.lng ?? 106.7,
                                            );
                                      });
                                    } else if (state.categoryId ==
                                        DeliveryType.takeOut) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => RepositoryProvider<
                                              StoreRepository>(
                                            create: (ctx2) =>
                                                StoreApiRepository(),
                                            child: MultiBlocProvider(
                                              providers: [
                                                BlocProvider<StoreCubit>(
                                                  create: (ctx) => StoreCubit(
                                                    repository:
                                                        RepositoryProvider.of<
                                                                StoreRepository>(
                                                            ctx),
                                                  ),
                                                ),
                                                BlocProvider<
                                                    IntervalBloc<StoreModel>>(
                                                  create: (ctx) =>
                                                      IntervalBloc<StoreModel>(
                                                    submit: BlocProvider.of<
                                                        StoreCubit>(ctx),
                                                  ),
                                                ),
                                              ],
                                              child: Builder(
                                                builder: (context) {
                                                  return StoreSearchScreen(
                                                    onClick: (StoreModel
                                                        store) async {
                                                      context
                                                          .read<StoreCubit>()
                                                          .getDetailStore(
                                                              store.id)
                                                          .then((detail) {
                                                        if (detail != null) {
                                                          context
                                                              .read<CartCubit>()
                                                              .setStore(
                                                                store,
                                                                detail,
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .categories,
                                                              );
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .updateUnavailable(
                                                                categories: detail
                                                                    .unavailableCategories,
                                                                products: detail
                                                                    .unavailableProducts,
                                                                options: detail
                                                                    .unavailableOptions,
                                                              );
                                                          context
                                                              .read<CartCubit>()
                                                              .setCategory(1);
                                                          context
                                                              .read<CartCubit>()
                                                              .setPayType(1);
                                                          context
                                                              .read<CartCubit>()
                                                              .setAddress(
                                                                store.address,
                                                                positionToDistanceString(
                                                                  store.lat,
                                                                  store.lng,
                                                                  context
                                                                      .read<
                                                                          GeolocatorCubit>()
                                                                      .state
                                                                      .latLng
                                                                      .latitude,
                                                                  context
                                                                      .read<
                                                                          GeolocatorCubit>()
                                                                      .state
                                                                      .latLng
                                                                      .longitude,
                                                                ),
                                                                store.lat,
                                                                store.lng,
                                                              );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .clearSnackBars();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                'Không tìm thấy cửa hàng. Hãy thử lại!',
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      });
                                                      Navigator.pop(ctx);
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  leading: const Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    '${state.addressName}',
                                    style: const TextStyle(
                                      fontSize: fontSM,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 0,
                                ),
                                const Divider(height: 4, thickness: spaceXXS),
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
                                            () {
                                              showModalBottomSheet(
                                                context: context,
                                                backgroundColor: Colors.white,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                                ),
                                                builder: (context) {
                                                  return ReceiverBottomSheet(
                                                    name: state.receiver,
                                                    phone: state.phone,
                                                  );
                                                },
                                              );
                                            },
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
                                        child: _getInfoItemTime(
                                          state.receivingTime,
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
                            (state.categoryId == DeliveryType.takeOut)
                                ? 0
                                : state.fee,
                            state.voucherDiscount,
                            state.voucher?.name ?? '',
                          ),
                          const SizedBox(height: 8),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: const ProductsSuggestWidget(
                              height: 307,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _getMethod(
                              state.categoryId,
                              state.payType == 0
                                  ? PayMethod(
                                      name: 'Tiền mặt',
                                      type: PayMethodType.cash,
                                      image:
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxVK2Ldio3wbcompe76GCOvyURqeR96FG-Ow&usqp=CAU',
                                    )
                                  : PayMethod(
                                      name: 'Momo',
                                      type: PayMethodType.momo,
                                      image:
                                          'https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png',
                                    )),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  _getOrderField(
                    state.categoryId?.name ?? '',
                    state.amount,
                    state.calculateCost,
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

  Widget _getInfoItemTime(DateTime? receivingTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dateToString(DateTime.now(), 'dd/MM'),
          style: const TextStyle(
            fontSize: fontSM,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: spaceXXS),
        const Text(
          'Càng sớm càng tốt',
          style: TextStyle(
            fontSize: fontMD,
            color: Colors.black,
          ),
        ),
      ],
    );
    // var now = DateTime.now();
    // if (now.hour > 21) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Text(
    //         dateToString(now.add(const Duration(days: 1)), 'dd/MM'),
    //         style: const TextStyle(
    //           fontSize: fontSM,
    //           color: Colors.black54,
    //         ),
    //       ),
    //       const SizedBox(height: spaceXXS),
    //       const Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             '07:30',
    //             style: TextStyle(
    //               fontSize: fontMD,
    //               color: Colors.black,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   );
    // } else if (now.hour < 7) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Text(
    //         dateToString(now, 'dd/MM'),
    //         style: const TextStyle(
    //           fontSize: fontSM,
    //           color: Colors.black54,
    //         ),
    //       ),
    //       const SizedBox(height: spaceXXS),
    //       const Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             '07:00',
    //             style: TextStyle(
    //               fontSize: fontMD,
    //               color: Colors.black,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   );
    // }
    // return InkWell(
    //   onTap: () {
    //     showModalBottomSheet(
    //       context: context,
    //       backgroundColor: Colors.white,
    //       shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.vertical(
    //           top: Radius.circular(16),
    //         ),
    //       ),
    //       builder: (context) {
    //         return TimePickerBottomSheet(
    //           current: receivingTime,
    //         );
    //       },
    //     ).then((value) {
    //       context.read<CartCubit>().setReceivingTime(value);
    //     });
    //   },
    //   child: Ink(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text(
    //           dateToString(now, 'dd/MM'),
    //           style: const TextStyle(
    //             fontSize: fontSM,
    //             color: Colors.black54,
    //           ),
    //         ),
    //         const SizedBox(height: spaceXXS),
    //         Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(
    //               receivingTime == null
    //                   ? "Càng sớm càng tốt"
    //                   : dateToString(receivingTime, 'HH:mm'),
    //               style: const TextStyle(
    //                 fontSize: fontMD,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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
            contentPadding: const EdgeInsets.symmetric(
              vertical: spaceXS,
              horizontal: spaceSM,
            ),
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
                      onPressed: (ctx) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) {
                            return BlocProvider<ProductCubit>.value(
                              value: BlocProvider.of<ProductCubit>(context),
                              child:
                                  ProductEditBottomSheet(product: products[i]),
                            );
                          },
                        );
                      },
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
                        var message =
                            await context.read<CartCubit>().deleteProduct(
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
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                    product.id,
                    e.options,
                  )) *
              e.amount,
        );
      }
    }
  }

  int getCostOptions(
    BuildContext context,
    String productId,
    List<String> options,
  ) {
    return context.read<ProductCubit>().getCostOptionsItem(
              productId,
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
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(model.options
              .map((e) => context
                  .read<ProductCubit>()
                  .getProductOptionItemById(model.id, e)
                  ?.name)
              .join(', ')),
          if (model.note.isNotEmpty) Text('Ghi chú: ${model.note}'),
        ],
      ),
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

  Widget _getMethod(DeliveryType? type, PayMethod _pay) {
    return InkWell(
      onTap: () async {
        var pay = await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => PayMethodBottomSheet(
            deliveryType: type,
            selected: _pay.type,
          ),
        );
        if (mounted) {
          context
              .read<CartCubit>()
              .setPayType(pay.type == PayMethodType.cash ? 0 : 1);
        }
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
            var res = await context.read<CartCubit>().create();

            String? id;

            AppMessage? message;

            if (res.type == ResponseModelType.success) {
              id = res.data;
            } else {
              message = res.message;
            }

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

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<CartDetailCubit>(
                            create: (context) => CartDetailCubit(
                              repository: RepositoryProvider.of<CartRepository>(
                                context,
                              ),
                              id: id!,
                            ),
                          ),
                          BlocProvider<CartsCubit>.value(
                            value: RepositoryProvider.of<CartsCubit>(
                              context,
                            ),
                          ),
                        ],
                        child: const CartDetailScreen(),
                      );
                    },
                  ),
                );

                context.read<AppBarCubit>().reloadAppBar();
              } else {
                Navigator.pop(context);
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return AppDialog(
                      message: message!,
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
