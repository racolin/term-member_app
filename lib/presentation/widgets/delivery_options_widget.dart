import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/blocs/store_bloc.dart';
import '../business_logic/cubits/cart_cubit.dart';
import '../../presentation/pages/store_search_widget.dart';
import '../../presentation/widgets/delivery_option_widget.dart';

import '../business_logic/cubits/home_cubit.dart';
import '../business_logic/cubits/home_state.dart';
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
              image:
                  'https://static.vecteezy.com/system/resources/previews/008/492/234/original/delivery-cartoon-illustration-png.png',
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
                    builder: (ctx) => BlocProvider<StoreBloc>.value(
                      value: context.read<StoreBloc>(),
                      child: StoreSearchPage(
                        onCLick: (StoreShortModel store) {
                          Navigator.pop(context);
                          context.read<CartCubit>().setStore(store);
                          context.read<HomeCubit>().setStore(store);
                        },
                      ),
                    ),
                  ),
                );
              },
              name: txtOptionTake,
              image:
                  'https://www.drench-design.com/wp-content/uploads/2018/10/coffeetype2.png',
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
