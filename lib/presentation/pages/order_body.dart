import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/states/product_state.dart';
import '../../presentation/res/dimen/dimens.dart';
import '../../presentation/widgets/product/products_suggest_widget.dart';
import '../../business_logic/cubits/product_scroll_cubit.dart';
import '../../business_logic/states/product_scroll_state.dart';
import '../../data/models/product_model.dart';
import '../widgets/product/product_categories_widget.dart';
import '../widgets/product/product_horizontal_widget.dart';

class OrderBody extends StatefulWidget {
  final VoidCallback onScroll;
  final int perRow = 4;
  final int row = 2;
  final bool login;

  const OrderBody({
    Key? key,
    required this.onScroll,
    this.login = false,
  }) : super(key: key);

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  final _scrollController = ScrollController();
  final heights = <double>[];

  double oldPixel = 0;
  double gap = 2;
  double direction = -1;

  double suggestHeight = 268;

  void scrollToCategories(int index) {
    _scrollController.animateTo(
      heights[index].toDouble(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductScrollCubit, ProductScrollState>(
      listener: (context, state) {
        if (state is ProductScrollLoaded) {
          scrollToCategories(state.index);
        }
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductInitial:
              return const SizedBox();
            case ProductLoading:
              return const SizedBox();
            case ProductLoaded:
              state as ProductLoaded;
              var listType = state.listType;
              if (heights.isEmpty) {
                heights.add(dimXL * widget.row + spaceSM * 2);
                for (int index = 1; index < listType.length; index++) {
                  heights.add(heights[index - 1]);
                  if (index == 1 && widget.login) {
                    heights[index] += 307;
                  }
                  heights[index] += 43 +
                      116 *
                          state
                              .getProductsByCategoryId(listType[index - 1].id)
                              .length;
                }
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (!notification.metrics.outOfRange) {
                    if ((notification.metrics.pixels - oldPixel).abs() > gap &&
                        notification.metrics.axis == Axis.vertical) {
                      double sub = notification.metrics.pixels - oldPixel;
                      if (direction * sub > 0) {
                        direction = -direction;
                        widget.onScroll();
                      }
                    }
                    oldPixel = notification.metrics.pixels;
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // height: 90 + 2 * spaceSM
                        return ProductCategoriesWidget(
                          maxItem: 8,
                          scrollTo: (index) {
                            context.read<ProductScrollCubit>().setIndex(index);
                          },
                        );
                      }
                      if (index == 2) {
                        if (widget.login) {
                          // 18 * 1.25 + 268 + 4 * 2 + 8 = 307
                          return const ProductsSuggestWidget(height: 307);
                        } else {
                          return const SizedBox();
                        }
                      }
                      if (index == listType.length + 2) {
                        return const SizedBox(
                          height: dimLG,
                        );
                      }
                      // height: 43 + 116 * n
                      return _getListProduct(
                        listType[index - (index > 2 ? 2 : 1)].name,
                        state.getProductsByCategoryId(
                          listType[index - (index > 2 ? 2 : 1)].id,
                        ),
                      );
                    },
                    itemCount: listType.length + 3,
                  ),
                ),
              );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _getListProduct(
    String title,
    List<ProductModel> shortProducts,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // height: 22.5 + 4 * 2 + 12 = 42.5
      children: [
        const SizedBox(height: spaceSM),
        Padding(
          // height: 22.5 + 4 * 2 = 30.5
          padding: const EdgeInsets.symmetric(
            vertical: spaceXXS,
            horizontal: spaceXS,
          ),
          child: Text(
            // height: 18 * 1.25 = 22.5
            title,
            style: const TextStyle(
              height: 1.25,
              fontSize: fontLG,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            // height: 116
            padding: const EdgeInsets.all(spaceXS),
            child: ProductHorizontalWidget(
              // height: 100
              model: shortProducts[index],
            ),
          ),
          itemCount: shortProducts.length,
        )
      ],
    );
  }
}
