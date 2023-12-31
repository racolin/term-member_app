import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_cubit.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/cubits/cart_cubit.dart';
import '../../business_logic/states/cart_state.dart';
import '../../business_logic/states/home_state.dart';
import '../../presentation/widgets/product/product_horizontal_widget.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/states/product_state.dart';
import '../bottom_sheet/method_order_bottom_sheet.dart';
import '../widgets/floating_action_widget.dart';

class ProductFavoriteScreen extends StatefulWidget {
  const ProductFavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductFavoriteScreen> createState() => _ProductFavoriteScreenState();
}

class _ProductFavoriteScreenState extends State<ProductFavoriteScreen> {
  bool expanded = false;

  double oldPixel = 0;
  double gap = 2;
  double direction = -1;

  @override
  void initState() {
    context.read<ProductCubit>().loadFavorites();
    super.initState();
  }

  void onScroll() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProductInitial:
            return const Scaffold();
          case ProductLoading:
            return const Scaffold(body: LoadingPage(),);
          case ProductLoaded:
            state as ProductLoaded;
            var list = state.getFavorites();
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  splashRadius: spaceXL,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
                title: Text(
                  txtFavoriteProducts,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              body: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (!notification.metrics.outOfRange) {
                    if ((notification.metrics.pixels - oldPixel).abs() > gap &&
                        notification.metrics.axis == Axis.vertical) {
                      double sub = notification.metrics.pixels - oldPixel;
                      if (direction * sub > 0) {
                        direction = -direction;
                        onScroll();
                      }
                    }
                    oldPixel = notification.metrics.pixels;
                  }
                  return true;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: spaceXXS),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(spaceXS),
                      child: ProductHorizontalWidget(model: list[index]),
                    );
                  },
                  itemCount: list.length,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, homeState) {
                  switch (homeState.runtimeType) {
                    case HomeLoaded:
                      homeState as HomeLoaded;
                      return (homeState.type == HomeBodyType.home ||
                              homeState.type == HomeBodyType.order)
                          ? BlocBuilder<CartCubit, CartState>(
                              builder: (context, cartState) {
                                if (cartState is CartLoaded) {
                                  return FloatingActionWidget(
                                    addressName: cartState.addressName,
                                    type: cartState.categoryId,
                                    amount: cartState.payType,
                                    cost: cartState.calculateCost,
                                    expanded: expanded,
                                    onClick: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16),
                                          ),
                                        ),
                                        builder: (ctx) =>
                                            MethodOrderBottomSheet(
                                          type: cartState.categoryId,
                                          addressName: cartState.addressName,
                                          login: context.read<HomeCubit>().login,
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const SizedBox();
                              },
                            )
                          : const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}
