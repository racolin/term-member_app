import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/states/product_state.dart';
import 'product_suggest_widget.dart';

class SuggestProductsWidget extends StatefulWidget {
  const SuggestProductsWidget({Key? key}) : super(key: key);

  @override
  State<SuggestProductsWidget> createState() => _SuggestProductsWidgetState();
}

class _SuggestProductsWidgetState extends State<SuggestProductsWidget> {
  final double height = 268;
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
            return IntrinsicHeight(
              // height: 301
              child: Column(
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
                      txtSuggestProduct,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: fontLG,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height,
                    child: ListView.builder(
                      itemCount: state.suggestion.length,
                      itemBuilder: (context, index) {
                        return ProductSuggestWidget(
                          product: state.suggestion[index],
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}
