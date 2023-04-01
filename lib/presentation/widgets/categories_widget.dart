import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/card_cubit.dart';
import 'package:member_app/business_logic/cubits/card_state.dart';
import 'package:member_app/business_logic/cubits/category_product_cubit.dart';
import 'package:member_app/business_logic/cubits/category_product_state.dart';

import '../res/dimen/dimens.dart';
import 'category_widget.dart';

class CategoriesWidget extends StatelessWidget {
  final Function(int) scrollTo;

  const CategoriesWidget({
    Key? key,
    required this.scrollTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductCubit, CategoryProductState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CategoryProductInitial:
            return const SizedBox();
          case CategoryProductLoading:
            return const SizedBox();
          case CategoryProductLoaded:
            state as CategoryProductLoaded;
            return GridView.builder(
              padding: const EdgeInsets.all(spaceSM),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 90,
                mainAxisExtent: 90,
                crossAxisSpacing: 28,
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  scrollTo(index);
                },
                child: CategoryWidget(
                  category: state.categories[index],
                ),
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}
