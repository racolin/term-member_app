import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';
import 'package:member_app/supports/convert.dart';

import '../../business_logic/cubits/cart_template_cubit.dart';
import '../../business_logic/states/cart_template_state.dart';
import '../../data/models/cart_template_model.dart';
import '../../presentation/res/dimen/dimens.dart';
import '../pages/loading_page.dart';
import '../res/strings/values.dart';

class ReOrdersWidget extends StatefulWidget {
  const ReOrdersWidget({Key? key}) : super(key: key);

  @override
  State<ReOrdersWidget> createState() => _ReOrdersWidgetState();
}

class _ReOrdersWidgetState extends State<ReOrdersWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartTemplateCubit, CartTemplateState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartTemplateInitial:
            return const LoadingPage();
          case CartTemplateLoading:
            return const LoadingPage();
          case CartTemplateLoaded:
            state as CartTemplateLoaded;
            if (state.list.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: spaceXS,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spaceXS,
                    vertical: spaceXXS,
                  ),
                  child: Text(
                    txtReOrderTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontLG,
                    ),
                  ),
                ),
                for (var cart in state.list.sublist(0, 3))
                  ReorderWidget(cart: cart),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }
}

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
