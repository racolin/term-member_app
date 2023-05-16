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
import '../../../data/repositories/mock/store_mock_repository.dart';
import '../../../presentation/pages/store_search_page.dart';
import '../../app_router.dart';
import '../../bottom_sheet/method_order_bottom_sheet.dart';
import 'delivery_option_widget.dart';

import '../../../data/models/store_model.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';

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
                  var state = context.read<CartCubit>().state;
                  if (state is CartLoaded) {
                    if (state.categoryId == DeliveryType.delivery) {
                      context.read<HomeCubit>().setBody(HomeBodyType.order);
                    } else if (state.categoryId == DeliveryType.takeOut) {
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
                              child: StoreSearchPage(
                                onClick: (StoreModel store) {
                                  Navigator.pop(ctx);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (context) => const MethodOrderBottomSheet(
                          type: null,
                          addressName: null,
                        ),
                      );
                    }
                  }
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
                var state = context.read<CartCubit>().state;
                if (state is CartLoaded) {
                  if (state.categoryId == DeliveryType.delivery) {
                    Navigator.pushNamed(context, AppRouter.addressSearch);
                  } else if (state.categoryId == DeliveryType.takeOut) {
                    context.read<HomeCubit>().setBody(HomeBodyType.order);
                  } else {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (context) => const MethodOrderBottomSheet(
                        type: null,
                        addressName: null,
                      ),
                    );
                  }
                }
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
