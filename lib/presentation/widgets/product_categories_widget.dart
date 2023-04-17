import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/states/product_state.dart';
import '../res/dimen/dimens.dart';
import 'product_category_widget.dart';

class ProductCategoriesWidget extends StatelessWidget {
  final Function(int) scrollTo;

  const ProductCategoriesWidget({
    Key? key,
    required this.scrollTo,
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
            return GridView.builder(
              padding: const EdgeInsets.all(spaceSM),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 90,
                mainAxisExtent: 90,
                crossAxisSpacing: spaceXL,
              ),
              itemCount: state.listType.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  scrollTo(index);
                },
                child: ProductCategoryWidget(
                  category: state.listType[index],
                ),
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}
