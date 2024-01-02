import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/cubits/cart_template_cubit.dart';
import 'package:member_app/business_logic/cubits/carts_cubit.dart';
import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/data/models/cart_template_model.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/bottom_sheet/cart_bottom_sheet.dart';
import 'package:member_app/presentation/bottom_sheet/cart_review_bottom_sheet.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';

import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/cart/cart_total_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../business_logic/cubits/cart_detail_cubit.dart';
import '../../../business_logic/states/cart_detail_state.dart';
import '../../../data/models/cart_detail_model.dart';
import '../../../data/models/response_model.dart';
import '../../../supports/convert.dart';
import '../../bottom_sheet/cart_review_shipper_bottom_sheet.dart';
import '../../widgets/cart/cart_product_widget.dart';

class CartDetailScreen extends StatefulWidget {
  const CartDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen> {
  Future<void> _showReview(
    String id,
    String type,
    String name,
    List<CartProductModel> products,
  ) async {
    int? rate = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BlocProvider<CartDetailCubit>.value(
        value: BlocProvider.of<CartDetailCubit>(context),
        child: CartReviewBottomSheet(
          id: id,
          type: type,
          name: name,
          products: products,
        ),
      ),
    );

    if (mounted && rate != null) {
      context.read<CartsCubit>().setReview(id, rate);
    }
  }

  Future<void> _showReviewShipper(
    String id,
    String type,
    String name,
  ) async {
    var rv = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BlocProvider<CartDetailCubit>.value(
        value: BlocProvider.of<CartDetailCubit>(context),
        child: CartReviewShipperBottomSheet(
          id: id,
          type: type,
          name: name,
        ),
      ),
    );
    if (rv != null && rv is CartReviewShipperModel && mounted) {
      context.read<CartDetailCubit>().setReviewShipper(rv);
    }
  }

  String getBackgroundImage(String type) {
    if (type == 'done') {
      return 'assets/images/done.jpeg';
    } else if (type == 'processing') {
      return 'assets/images/processing.png';
    } else if (type == 'canceled') {
      return 'assets/images/canceled.png';
    } else {
      return 'assets/images/pending.jpeg';
    }
    return 'assets/images/canceled.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(fontSize: 16),
        ),
        elevation: 0,
        leading: IconButton(
          splashRadius: 28,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: BlocConsumer<CartDetailCubit, CartDetailState>(
        listener: (context, state) {
          if (state is CartDetailLoaded) {
            if (state.cart.status == 'done' && state.cart.review == null) {
              // if (true) {
              _showReview(
                state.cart.id,
                state.cart.categoryId.name,
                state.cart.name,
                state.cart.products,
              );
            }
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartDetailInitial:
              return const SizedBox();
            case CartDetailLoading:
              return const LoadingPage();
            case CartDetailLoaded:
              state as CartDetailLoaded;
              // printstate.cart.toMap());
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      getBackgroundImage(
                        state.cart.status,
                      ),
                      height: 300,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    if (state.cart.status == 'done')
                      _getReview(
                        state.cart.review,
                        state.cart.id,
                        state.cart.categoryId.name,
                        state.cart.name,
                        state.cart.products,
                      ),
                    const SizedBox(height: spaceXS),
                    _support(context, state.cart),
                    if (state.cart.timeLog != null) ...[
                      const SizedBox(height: spaceXS),
                      _getTimeLog(state.cart.timeLog!),
                    ],
                    const SizedBox(height: spaceXS),
                    _getInfo(state.cart),
                    const SizedBox(height: spaceXS),
                    _getProducts(state.cart.products),
                    const SizedBox(height: spaceXS),
                    CartTotalWidget(
                      total: state.cart.total,
                      originalFee: state.cart.originalFee,
                      fee: state.cart.fee,
                      voucherDiscount: state.cart.voucherDiscount,
                      voucherName: state.cart.voucherName,
                      payType: state.cart.payType,
                    ),
                    const SizedBox(height: dimMD),
                  ],
                ),
              );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _getReview(
    CartReviewModel? review,
    String id,
    String type,
    String name,
    List<CartProductModel> products,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            review == null
                ? 'Trải nghiệm của bạn như thế nào về đơn hàng này'
                : 'Cảm ơn bạn đã đánh giá đơn hàng của chúng tôi',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: spaceXXS),
          GestureDetector(
            onTap: review == null
                ? () {
                    _showReview(id, type, name, products);
                  }
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 0; i < 5; i++)
                  Icon(
                    Icons.star_rounded,
                    color:
                        (i < (review?.rate ?? 0)) ? Colors.orange : Colors.grey,
                    size: dimXS,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Widget _support(BuildContext context, CartDetailModel cart) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      width: double.maxFinite,
      color: Colors.white,
      child: Wrap(
        // alignment: ,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              _makePhoneCall("0868754872");
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spaceLG),
                ),
              ),
            ),
            child: Text(
              'Gọi hỗ trợ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(width: spaceXS),
          if (cart.status != 'processing' && cart.status != 'pending') ...[
            const SizedBox(width: spaceXS),
            ElevatedButton(
              onPressed: () async {
                var clear = true;
                clear = await showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return AppDialog(
                      message: AppMessage(
                        type: AppMessageType.notify,
                        title: txtNotifyTitle,
                        content: 'Đơn hàng hiên tại của bạn sẽ được xoá '
                            'và sẽ được thay thế bằng đơn hàng này?',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text(txtConfirm),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text(txtCancel),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    );
                  },
                );
                if (clear) {
                  if (context.mounted) {
                    //
                    var message =
                        await context.read<CartCubit>().addProductsToCart(
                              cart.products,
                              clear,
                            );
                    if (context.mounted) {
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
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceLG),
                  ),
                ),
              ),
              child: Text(
                'Đặt lại',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
          if (cart.reviewShipper == null &&
              cart.status == 'done' &&
              cart.categoryId == DeliveryType.delivery) ...[
            // if (cart.reviewShipper == null) ...[
            const SizedBox(width: spaceXS),
            ElevatedButton(
              onPressed: () async {
                _showReviewShipper(
                  cart.id,
                  cart.categoryId.name,
                  cart.name,
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceLG),
                  ),
                ),
              ),
              child: Text(
                'Đánh giá Shipper',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
          if (cart.isPaid == false && cart.payType == 1) ...[
            const SizedBox(width: spaceXS),
            ElevatedButton(
              onPressed: () async {
                showCupertinoDialog(
                  context: context,
                  builder: (ctx) {
                    return AppDialog(
                      message: AppMessage(
                        type: AppMessageType.notify,
                        title: txtNotifyTitle,
                        content:
                            'Thời gian đặt hàng sẽ được tính là bây giờ. Bạn có đồng ý không?',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('Không'),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('Có'),
                          onPressed: () {
                            context.read<CartDetailCubit>().createPayment();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đơn hàng đang được thực hiện!')),
                            );
                            Navigator.pop(ctx);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceLG),
                  ),
                ),
              ),
              child: Text(
                'Thanh toán',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(width: spaceXS),
            ElevatedButton(
              onPressed: () async {
                var message =
                    await context.read<CartsCubit>().cancelOrder(cart.id);

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
                    Navigator.pop(context);
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceLG),
                  ),
                ),
              ),
              child: Text(
                'Huỷ đơn',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
          const SizedBox(width: spaceXS),
          ElevatedButton(
            onPressed: () async {
              var res = await context
                  .read<CartTemplateCubit>()
                  .createTemplateFromCart(
                    cart.name,
                    cart.products,
                  );
              if (context.mounted) {
                if (res.type == ResponseModelType.success) {
                  // context.read<AppBarCubit>().reloadAppBar();
                  context.read<AppBarCubit>().addTemplateCart(1);
                  context.read<CartTemplateCubit>().add(
                        CartTemplateModel(
                          id: res.data,
                          name: cart.name,
                          index: context.read<CartTemplateCubit>().length,
                          products: cart.products
                              .map((e) => CartTemplateProductModel(
                                    options: e.options,
                                    amount: e.amount,
                                    id: e.id,
                                  ))
                              .toList(),
                        ),
                      );
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return AppDialog(
                        message: AppMessage(
                          type: AppMessageType.success,
                          title: txtSuccessTitle,
                          content: 'Thêm đơn hàng mẫu thành công. '
                              'Bạn có muốn chuyển đến trang '
                              'danh sách đơn hàng mẫu không?',
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(txtCancel),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text(txtConfirm),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                context,
                                AppRouter.cartTemplate,
                              );
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
                        message: res.message,
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
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spaceLG),
                ),
              ),
            ),
            child: Text(
              'Tạo đơn mẫu',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTimeLog(List<CartTimeLog> timeLog) {
    return Container(
      color: Colors.white,
      child: ExpansionTile(
        title: Text(
          'Chi tiết đơn hàng',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        children: timeLog
            .map((e) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: spaceMD),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dateToString(e.time, 'HH:mm dd/MM'),
                            style: const TextStyle(
                              fontSize: fontSM,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: spaceXXS),
                          Text(
                            e.title,
                            style: const TextStyle(
                              fontSize: fontMD,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: spaceMD),
                        ],
                      ),
                    ),
                    const SizedBox(width: spaceSM),
                    Expanded(
                      flex: 2,
                      child: Text(
                        e.description,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: fontMD,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: spaceMD),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _getInfo(CartDetailModel cart) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin đơn hàng',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (cart.point != null && cart.status == 'done') ...[
                  // if (true) ...[
                  const SizedBox(height: spaceXS),
                  Text(
                    'Bạn nhận được ${cart.point} ${txtPointName}s cho đơn hàng này',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.orange,
                        ),
                  ),
                ],
                if (cart.reviewPoint != null && cart.status == 'done') ...[
                  // if (true) ...[
                  const SizedBox(height: spaceXS),
                  Text(
                    'Cộng ${cart.point} ${txtPointName}s khi đánh giá đơn hàng',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.orange,
                        ),
                  ),
                ],
                if (cart.reviewPoint != null && cart.status == 'done') ...[
                  // if (true) ...[
                  const SizedBox(height: spaceXS),
                  Text(
                    'Cộng ${cart.point} ${txtPointName}s khi đánh giá Shipper',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.orange,
                        ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: spaceSM),
          SizedBox(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _getInfoItem('Tên người nhận', cart.receiver),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: double.maxFinite,
                  width: 0.5,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _getInfoItem('Số điện thoại', cart.phone),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: spaceSM),
          const Divider(height: 1),
          const SizedBox(height: spaceSM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _getInfoItem(cart.categoryId.name, cart.addressName),
          ),
          const SizedBox(height: spaceSM),
          const Divider(height: 1),
          const SizedBox(height: spaceSM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: cart.status == 'done' || cart.isPaid == true
                ? _getInfoItem(
                    'Trạng thái thanh toán',
                    'Đã thanh toán',
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: fontLG,
                    ),
                  )
                : _getInfoItem(
                    'Trạng thái thanh toán',
                    'Chưa thanh toán',
                    Icon(
                      Icons.info_rounded,
                      color: cart.status == 'processing'
                          ? Colors.orange
                          : Colors.red,
                      size: fontLG,
                    ),
                  ),
          ),
          const SizedBox(height: spaceSM),
          const Divider(height: 1),
          const SizedBox(height: spaceSM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _getInfoItem('Mã đơn hàng', cart.code),
          ),
        ],
      ),
    );
  }

  Widget _getInfoItem(String name, String content, [Icon? icon]) {
    return Column(
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
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: fontMD,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getProducts(
    List<CartProductModel> products,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sản phẩm đã chọn',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) => CartProductWidget(
              amount: products[index].amount,
              name: products[index].name,
              note: products[index].note,
              cost: products[index].cost * products[index].amount,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
          ),
        ],
      ),
    );
  }
}
