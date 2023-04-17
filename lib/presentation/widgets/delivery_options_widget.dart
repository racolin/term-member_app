import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/store_cubit.dart';
import '../../business_logic/cubits/cart_cubit.dart';
import '../../business_logic/cubits/home_cubit.dart';
import '../../business_logic/states/home_state.dart';
import '../../presentation/pages/store_search_page.dart';
import '../../presentation/widgets/delivery_option_widget.dart';

import '../../data/models/store_model.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class DeliveryOptionsWidget extends StatelessWidget {
  const DeliveryOptionsWidget({Key? key}) : super(key: key);
  final double height = dimXL;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(spaceXS),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(spaceSM),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: DeliveryOptionWidget(
              onClick: () {
                context.read<HomeCubit>().setBody(HomeBodyType.order);
              },
              name: txtOptionDelivery,
              image: assetDeliveryImage,
              height: height,
            ),
          ),
          Container(
            height: height * 0.6,
            width: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(150),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Expanded(
            child: DeliveryOptionWidget(
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider<StoreCubit>.value(
                      value: context.read<StoreCubit>(),
                      child: StoreSearchPage(
                        onCLick: (StoreModel store) {
                          Navigator.pop(context);
                          // context.read<CartCubit>().setStore(store);
                        },
                      ),
                    ),
                  ),
                );
              },
              name: txtOptionTake,
              image: assetTakeAwayImage,
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
