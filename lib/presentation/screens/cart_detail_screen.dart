import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/bottom_sheet/cart_review_bottom_sheet.dart';

import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/supports/convert.dart';

import '../../business_logic/cubits/cart_detail_cubit.dart';
import '../../business_logic/states/cart_detail_state.dart';
import '../../data/models/cart_detail_model.dart';

class CartDetailScreen extends StatefulWidget {
  const CartDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen> {
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
      body: BlocBuilder<CartDetailCubit, CartDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartDetailInitial:
              return const SizedBox();
            case CartDetailLoading:
              return const LoadingPage();
            case CartDetailLoaded:
              state as CartDetailLoaded;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/card_background_no_auth.png',
                      height: 300,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    _getReview(
                      state.cart.review,
                      state.cart.categoryId.name,
                      state.cart.name,
                    ),
                    const SizedBox(height: spaceXS),
                    _support(context),
                    const SizedBox(height: spaceXS),
                    _getInfo(state.cart, true),
                    const SizedBox(height: spaceXS),
                    _getProducts(state.cart.products),
                    const SizedBox(height: spaceXS),
                    _getTotal(
                      state.cart.total,
                      state.cart.fee,
                      state.cart.voucherDiscount,
                      state.cart.voucherName,
                      state.cart.payType,
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

  Widget _getReview(CartReviewModel? review, String type, String name) {
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
          GestureDetector(
            onTap: review == null
                ? () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CartReviewBottomSheet(
                        type: type,
                        name: name,
                      ),
                    );
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

  Widget _support(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      width: double.maxFinite,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          // alignment: ,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {},
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
            ElevatedButton(
              onPressed: () {},
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
            const SizedBox(width: spaceXS),
            ElevatedButton(
              onPressed: () {},
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
        ),
      ),
    );
  }

  Widget _getInfo(CartDetailModel cart, bool payStatus) {
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
                if (cart.point != null) ...[
                  const SizedBox(height: spaceSM),
                  Text(
                    'Bạn nhận được ${cart.point} ${txtPointName}s cho đơn hàng này',
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
            height: 36,
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
            child: _getInfoItem('Giao đến', cart.addressName),
          ),
          const SizedBox(height: spaceSM),
          const Divider(height: 1),
          const SizedBox(height: spaceSM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: payStatus
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
                    const Icon(
                      Icons.info_rounded,
                      color: Colors.red,
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
            itemBuilder: (context, index) => _getProduct(
              products[index],
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
          ),
        ],
      ),
    );
  }

  Widget _getProduct(CartProductModel model) {
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
      subtitle: Text(model.options.join(', ')),
      trailing: Text(
        numberToCurrency(model.cost, 'đ'),
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
    int payType,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Tổng cộng',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thành tiền',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: fontMD,
                      ),
                ),
                Text(
                  numberToCurrency(total, 'đ'),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                      ),
                )
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phí vận chuyển',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: fontMD,
                      ),
                ),
                Text(
                  numberToCurrency(fee, 'đ'),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                      ),
                )
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khuyến mãi',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: fontMD,
                            color: Colors.blue,
                          ),
                    ),
                    Text(
                      voucherName,
                    ),
                  ],
                ),
                Text(
                  numberToCurrency(voucherDiscount, 'đ'),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Số tiền thanh toán',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: fontMD,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  numberToCurrency(total - voucherDiscount, 'đ'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
