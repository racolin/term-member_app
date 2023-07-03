import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/carts_cubit.dart';

import '../../business_logic/cubits/cart_cubit.dart';
import '../../business_logic/cubits/cart_template_cubit.dart';
import '../../business_logic/states/cart_template_state.dart';
import '../../business_logic/states/carts_state.dart';
import '../pages/loading_page.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';
import 'cart/re_order_widget.dart';
import 'cart_template_widget.dart';

class ReOrdersWidget extends StatefulWidget {
  const ReOrdersWidget({Key? key}) : super(key: key);

  @override
  State<ReOrdersWidget> createState() => _ReOrdersWidgetState();
}

class _ReOrdersWidgetState extends State<ReOrdersWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartsCubit, CartsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartsInitial:
            return const LoadingPage();
          case CartsLoading:
            return const LoadingPage();
          case CartsLoaded:
            state as CartsLoaded;
            var list = state.listCarts.values
                .map((e) => e.list)
                .expand((e) => e)
                .toList();
            list = list.length > 3 ? list.sublist(0, 3) : list;
            return FutureBuilder(
              future: context
                  .read<CartCubit>()
                  .getDetails(list.map((e) => e.id).toList()),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
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
                      for (var cart in snapshot.data!)
                        ReOrderWidget(cart: cart),
                    ],
                  );
                }
                return const SizedBox();
              },
            );
        }
        return const SizedBox();
      },
    );
  }
}
