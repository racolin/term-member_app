import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubits/product_cubit.dart';
import '../../../business_logic/cubits/product_scroll_cubit.dart';
import '../../../business_logic/states/product_state.dart';
import '../../../data/models/product_category_model.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';
import '../drag_bar_widget.dart';
import 'product_category_widget.dart';

class ProductCategoriesWidget extends StatelessWidget {
  final Function(int) scrollTo;
  final int maxItem;

  const ProductCategoriesWidget({
    Key? key,
    required this.scrollTo,
    required this.maxItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProductInitial:
            return const SizedBox();
          case ProductLoading:
            return const SizedBox();
          case ProductLoaded:
            state as ProductLoaded;
            var categories = <ProductCategoryModel?>[];
            if (state.listType.length > maxItem) {
              categories.addAll(state.listType.sublist(0, maxItem - 1));
              categories.add(null);
            } else {
              categories = state.listType;
            }
            return GridView.builder(
              padding: const EdgeInsets.all(spaceSM),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: dimXL,
                mainAxisExtent: dimXL,
                crossAxisSpacing: spaceXL,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  if (categories[index] != null) {
                    scrollTo(index);
                  } else {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (ctx) {
                        return BlocProvider<ProductCubit>.value(
                          value: context.read<ProductCubit>(),
                          child: Container(
                            padding:
                            const EdgeInsets.only(bottom: spaceXXL),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(spaceMD),
                              ),
                              color: Colors.white,
                            ),
                            child: Wrap(
                              children: [
                                const DragBarWidget(margin: spaceXS),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: spaceMD,
                                  ),
                                  child: Text(
                                    txtCategory,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontLG,
                                      color: Colors.black.withAlpha(180),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                ProductCategoriesWidget(
                                  maxItem: 100,
                                  scrollTo: (index) {
                                    context
                                        .read<ProductScrollCubit>()
                                        .setIndex(index);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: ProductCategoryWidget(
                  category: categories[index],
                ),
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}
