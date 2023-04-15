import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/category_product_cubit.dart';
import 'package:member_app/business_logic/cubits/category_product_state.dart';
import 'package:member_app/business_logic/cubits/product_cubit.dart';
import 'package:member_app/business_logic/states/product_state.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/suggest_products_widget.dart';

import '../../business_logic/cubits/category_scroll_cubit.dart';
import '../../business_logic/cubits/category_scroll_state.dart';
import '../../data/models/product_model.dart';
import '../widgets/product_categories_widget.dart';
import '../widgets/product_widget.dart';

class OrderBody extends StatefulWidget {
  const OrderBody({Key? key}) : super(key: key);

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  final _scrollController = ScrollController();
  final heights = <int>[];

  void scrollToCategories(int index) {
    _scrollController.animateTo(
      heights[index].toDouble(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryScrollCubit, CategoryScrollState>(
      listener: (context, state) {
        if (state is CategoryScrollIndex) {
          scrollToCategories(state.index);
        }
      },
      child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CategoryProductInitial:
              return const SizedBox();
            case CategoryProductLoading:
              return const SizedBox();
            case CategoryProductLoaded:
              state as CategoryProductLoaded;

              return BlocBuilder<ProductCubit, ProductState>(
                builder: (context, stateProduct) {
                  switch (stateProduct.runtimeType) {
                    case ProductInitial:
                      return const SizedBox();
                    case ProductLoading:
                      return const SizedBox();
                    case ProductLoaded:
                      stateProduct as ProductLoaded;
                      if (heights.isEmpty) {
                        heights.add(95 * (state.categories.length / 4).ceil());
                        for (int index = 1;
                            index < state.categories.length;
                            index++) {
                          heights.add(heights[index - 1]);
                          if (index == 1) {
                            heights[index] += 300;
                          }
                          heights[index] += 42 +
                              116 *
                                  stateProduct
                                      .getProductsByID(
                                          state.categories[index].productIDs)
                                      .length;
                        }
                      }
                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // height: 90
                            return ProductCategoriesWidget(
                              scrollTo: (index) {
                                context
                                    .read<CategoryScrollCubit>()
                                    .setIndex(index);
                              },
                            );
                          }
                          if (index == 2) {
                            // height: 301
                            return const SuggestProductsWidget();
                          }
                          if (index == state.categories.length + 2) {
                            return const SizedBox(
                              height: dimLG,
                            );
                          }
                          // height: 42 + 116 * n
                          return _getListProduct(
                            state.categories[index - (index > 2 ? 2 : 1)].name,
                            stateProduct.getProductsByID(
                              state.categories[index - (index > 2 ? 2 : 1)]
                                  .productIDs,
                            ),
                          );
                        },
                        itemCount: state.categories.length + 3,
                      );
                  }
                  return const SizedBox();
                },
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
      children: [
        const SizedBox(height: spaceSM),
        Padding(
          // height: 25
          padding: const EdgeInsets.symmetric(
              vertical: spaceXXS, horizontal: spaceXS),
          child: Text(
            // height: 17
            title,
            style: const TextStyle(
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
            child: ProductWidget(
              // height: 100
              shortProduct: shortProducts[index],
            ),
          ),
          itemCount: shortProducts.length,
        )
      ],
    );
  }
}
