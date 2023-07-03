import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubits/cart_template_cubit.dart';
import '../../business_logic/states/cart_template_state.dart';
import '../pages/loading_page.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';
import 'cart_template_widget.dart';

class ReTemplatesWidget extends StatefulWidget {
  const ReTemplatesWidget({Key? key}) : super(key: key);

  @override
  State<ReTemplatesWidget> createState() => _ReTemplatesWidgetState();
}

class _ReTemplatesWidgetState extends State<ReTemplatesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartTemplateCubit, CartTemplateState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartTemplateInitial:
            return const LoadingPage();
          case CartTemplateLoading:
            return const LoadingPage();
          case CartTemplateLoaded:
            state as CartTemplateLoaded;
            if (state.list.isEmpty) {
              return const SizedBox();
            }
            return Column(
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
                    txtReTemplateTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontLG,
                    ),
                  ),
                ),
                for (var cart in state.list.sublist(
                  0,
                  state.list.length < 3 ? state.list.length : 3,
                ))
                  CartTemplateWidget(cart: cart),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }
}
