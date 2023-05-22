import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/cart_cubit.dart';
import '../../business_logic/cubits/home_cubit.dart';
import '../../business_logic/states/cart_state.dart';
import '../../business_logic/states/home_state.dart';
import '../../data/models/product_model.dart';
import '../res/dimen/dimens.dart';
import '../bottom_sheet/method_order_bottom_sheet.dart';
import '../res/strings/values.dart';
import '../widgets/floating_action_widget.dart';
import '../widgets/product/product_widget.dart';

class ProductSearchScreen extends StatefulWidget {
  final Function(ProductModel) onClick;
  final bool withFloatingButton;
  final bool isTemplate;

  const ProductSearchScreen({
    Key? key,
    required this.onClick,
    this.withFloatingButton = true,
    this.isTemplate = false,
  }) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  bool expanded = false;

  double oldPixel = 0;
  double gap = 2;
  double direction = -1;

  @override
  void initState() {
    context.read<IntervalBloc<ProductModel>>().add(IntervalSearch(key: ''));
    super.initState();
  }

  void onScroll() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IntervalBloc<ProductModel>, IntervalState>(
        builder: (context, state) {
          var list = <ProductModel>[];
          if (state is IntervalLoaded<ProductModel>) {
            list = state.list;
          }
          return Column(
            children: [
              _getSearchBar(context),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (!notification.metrics.outOfRange) {
                      if ((notification.metrics.pixels - oldPixel).abs() >
                              gap &&
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: spaceXXS, bottom: dimMD),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(spaceXS),
                              child: ProductWidget(
                                model: list[index],
                                isTemplate: widget.isTemplate,
                              ),
                            );
                          },
                          itemCount: list.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !widget.withFloatingButton
          ? null
          : BlocBuilder<HomeCubit, HomeState>(
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
                                      builder: (ctx) => MethodOrderBottomSheet(
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

  Widget _getSearchBar(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: dimMD),
      padding: const EdgeInsets.all(spaceXS),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(spaceXS),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              onChanged: (value) {
                context
                    .read<IntervalBloc<ProductModel>>()
                    .add(IntervalSearch(key: value));
              },
            ),
          ),
          const SizedBox(
            width: spaceXXS,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(spaceXS),
            child: Container(
              padding: const EdgeInsets.all(spaceXXS),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(spaceXS),
              ),
              child: const Text(
                txtCancel,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
