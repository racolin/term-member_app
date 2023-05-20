import 'package:flutter/material.dart';

import '../../../supports/convert.dart';
import '../../res/dimen/dimens.dart';

class CartTotalWidget extends StatelessWidget {
  final int total;
  final int originalFee;
  final int fee;
  final int voucherDiscount;
  final String? voucherName;
  final int payType;

  const CartTotalWidget({
    Key? key,
    required this.total,
    required this.originalFee,
    required this.fee,
    required this.voucherDiscount,
    this.voucherName,
    required this.payType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (originalFee != fee) ...[
                      Text(
                        numberToCurrency(originalFee, 'đ'),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      const SizedBox(height: spaceXS),
                    ],
                    Text(
                      numberToCurrency(fee, 'đ'),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
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
                      voucherName ?? 'Không có',
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
                  numberToCurrency(total - voucherDiscount + fee, 'đ'),
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
