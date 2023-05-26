import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/res/dimen/dimens.dart';
import '../../../../presentation/res/strings/values.dart';
import '../../../business_logic/cubits/product_cubit.dart';
import '../../../business_logic/states/product_state.dart';
import 'product_suggest_widget.dart';

class ProductsSuggestWidget extends StatefulWidget {
  final double height;
  const ProductsSuggestWidget({Key? key, required this.height,}) : super(key: key);

  @override
  State<ProductsSuggestWidget> createState() => _ProductsSuggestWidgetState();
}

class _ProductsSuggestWidgetState extends State<ProductsSuggestWidget> {

 final double top = spaceXS;
 final double textHeight = 1.25;
 final double textFont = fontLG;
 final double textSpaceVertical = spaceXXS;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: top,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: spaceXS,
                      vertical: textSpaceVertical,
                    ),
                    child: Text(
                      txtSuggestProduct,
                      style: TextStyle(
                        height: textHeight,
                        fontWeight: FontWeight.w700,
                        fontSize: textFont,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.height - top - textHeight * textFont - textSpaceVertical * 2,
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
