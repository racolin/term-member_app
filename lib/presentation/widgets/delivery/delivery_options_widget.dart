import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/cubits/store_cubit.dart';
import 'package:member_app/business_logic/states/cart_state.dart';
import 'package:member_app/data/models/cart_model.dart';
import '../../../business_logic/blocs/interval/interval_bloc.dart';
import '../../../business_logic/cubits/home_cubit.dart';
import '../../../business_logic/repositories/store_repository.dart';
import '../../../business_logic/states/home_state.dart';
import '../../../data/repositories/api/store_api_repository.dart';
import '../../screens/store_search_screen.dart';
import '../../app_router.dart';
import 'delivery_option_widget.dart';

import '../../../data/models/store_model.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';

class DeliveryOptionsWidget extends StatelessWidget {
  const DeliveryOptionsWidget({Key? key, required this.login}) : super(key: key);
  final double height = dimLG;
  final bool login;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(spaceXS),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(spaceXS),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: DeliveryOptionWidget(
                onClick: () {
                  if (!login) {
                    Navigator.pushNamed(context, AppRouter.auth);
                    return;
                  }
                  var state = context.read<CartCubit>().state;
                  if (state is CartLoaded) {
                    if (state.categoryId == DeliveryType.delivery) {
                      context.read<HomeCubit>().setBody(HomeBodyType.order);
                    } else {
                      Navigator.pushNamed(context, AppRouter.addressSearch);
                    }
                  }
                },
              name: txtOptionDelivery,
              image: assetDeliveryImage,
              height: height,
            ),
          ),
          Expanded(
            child: DeliveryOptionWidget(
              onClick: () {
                if (!login) {
                  Navigator.pushNamed(context, AppRouter.auth);
                  return;
                }
                var state = context.read<CartCubit>().state;
                if (state is CartLoaded) {
                  if (state.categoryId == DeliveryType.delivery) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => RepositoryProvider<StoreRepository>(
                          create: (ctx) => StoreApiRepository(),
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider<StoreCubit>(
                                create: (ctx) => StoreCubit(
                                  repository: RepositoryProvider.of<StoreRepository>(ctx),
                                ),
                              ),
                              BlocProvider<IntervalBloc<StoreModel>>(
                                create: (ctx) => IntervalBloc<StoreModel>(
                                  submit:
                                  BlocProvider.of<StoreCubit>(ctx),
                                ),
                              ),
                            ],
                            child: StoreSearchScreen(
                              onClick: (StoreModel store) {
                                Navigator.pop(ctx);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    context.read<HomeCubit>().setBody(HomeBodyType.order);
                  }
                }
              },
              name: txtOptionTake,
              image: assetTakeAwayImage,
              height: height,
            ),
          ),
          Expanded(
            child: DeliveryOptionWidget(
              onClick: () {
                if (login) {
                  context.read<HomeCubit>().setBody(HomeBodyType.promotion);
                  return;
                }
                Navigator.pushNamed(context, AppRouter.auth);
              },
              name: "$txtSwap $txtPointName",
              image: assetExchangeImage,
              height: height,
            ),
          ),
          Expanded(
            child: DeliveryOptionWidget(
              onClick: () {
                if (login) {
                  return;
                }
                Navigator.pushNamed(context, AppRouter.auth);
              },
              name: txtCart,
              image: assetMyOrderImage,
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
