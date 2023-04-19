import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';
import 'package:member_app/supports/convert.dart';

import '../../../business_logic/cubits/cart_template_cubit.dart';
import '../../../business_logic/states/cart_template_state.dart';
import '../../../data/models/cart_template_model.dart';
import '../../res/dimen/dimens.dart';
import '../../pages/loading_page.dart';
import '../../res/strings/values.dart';

class ReorderWidget extends StatelessWidget {
  final CartTemplateModel cart;

  const ReorderWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Container(
              child: Text(
                cart.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
              ),
            ),
            const SizedBox(
              height: spaceXS,
            ),
            ...cart.products
                .map(
                  (e) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: AppImageWidget(
                      width: 36,
                      height: 36,
                      borderRadius: BorderRadius.circular(18),
                      assetsDefaultImage: assetDefaultIcon,
                      image:
                          'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
                    ),
                    trailing: Text(numberToCurrency(100000, 'đ')),
                    title: Text(
                      '${e.id} x ${e.amount}',
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
                      e.options.join(', '),
                    ),
                  ),
                )
                .toList(),
            Row(
              children: [
                Text(
                  'Tổng đơn: ${numberToCurrency(300000, 'đ')}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                ),
                const Spacer(),
                ElevatedButton(onPressed: () {}, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Đặt ngay'),
                    Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
