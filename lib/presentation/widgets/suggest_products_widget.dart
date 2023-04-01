import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/card_cubit.dart';
import 'package:member_app/business_logic/cubits/card_state.dart';
import 'package:member_app/presentation/widgets/product_suggest_widget.dart';
import 'package:member_app/business_logic/cubits/suggest_product_cubit.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/cubits/suggest_product_state.dart';

class SuggestProductsWidget extends StatefulWidget {
  const SuggestProductsWidget({Key? key}) : super(key: key);

  @override
  State<SuggestProductsWidget> createState() => _SuggestProductsWidgetState();
}

class _SuggestProductsWidgetState extends State<SuggestProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestProductCubit, SuggestProductState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SuggestProductInitial:
            return const SizedBox();
          case SuggestProductLoading:
            return const SizedBox();
          case SuggestProductLoaded:
            state as SuggestProductLoaded;
            return IntrinsicHeight(
              // height: 301
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: spaceXS,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: spaceXS,
                      vertical: spaceXXS,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          txtSuggestProduct,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: fontLG,
                          ),
                        ),
                        BlocBuilder<CardCubit, CardState>(
                          builder: (context, state) {
                            switch (state.runtimeType) {
                              case CardLoaded:
                                state as CardLoaded;
                                return Text(
                                  ' ${state.card.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: fontLG,
                                  ),
                                );
                            }
                            return const Text(
                              ' $txtETC',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: fontLG,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 268,
                    child: ListView.builder(
                      itemCount: state.suggests.length,
                      itemBuilder: (context, index) {
                        return ProductSuggestWidget(
                          product: state.suggests[index],
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
