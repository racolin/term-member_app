import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/states/cart_state.dart';

import '../../presentation/pages/initial_page.dart';
import '../../presentation/pages/promotion_body.dart';
import '../../presentation/pages/home_body.dart';
import '../../presentation/pages/order_body.dart';
import '../../presentation/pages/other_body.dart';
import '../../presentation/pages/store_body.dart';
import '../../presentation/pages/loading_page.dart';
import '../../presentation/widgets/app_bar_widget.dart';
import '../../presentation/widgets/floating_action_widget.dart';
import '../../business_logic/cubits/home_cubit.dart';
import '../../business_logic/states/home_state.dart';
import '../bottom_sheet/method_order_bottom_sheet.dart';
import '../widgets/navigation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    switch (state) {
      case AppLifecycleState.resumed:
        context.read<CartCubit>().loadCartLoaded();
        break;
      case AppLifecycleState.inactive:
        print('deb-inactive');
        break;
      case AppLifecycleState.paused:
        context.read<CartCubit>().saveCartLoaded();
        print('deb-paused');
        break;
      case AppLifecycleState.detached:
        print('deb-detached');
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  Widget _getBody(HomeBodyType type, bool login) {
    Widget body;
    switch (type) {
      case HomeBodyType.home:
        body = HomeBody(
          onScroll: () {
            setState(() {
              expanded = !expanded;
            });
          },
          login: login,
        );
        break;
      case HomeBodyType.order:
        body = OrderBody(
          onScroll: () {
            setState(() {
              expanded = !expanded;
            });
          },
          login: login,
        );
        break;
      case HomeBodyType.store:
        body = StoreBody(
          login: login,
        );
        break;
      case HomeBodyType.other:
        body = OtherBody(
          login: login,
        );
        break;
      case HomeBodyType.promotion:
        body = PromotionBody(
          login: login,
        );
        break;
      default:
        body = const LoadingPage();
        break;
    }
    return body;
  }

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(),
          body: Builder(
            builder: (context) {
              switch (state.runtimeType) {
                case HomeInitial:
                  return const InitialPage();
                case HomeLoading:
                  return const LoadingPage();
                case HomeLoaded:
                  return _getBody(
                    (state as HomeLoaded).type,
                    state.login,
                  );
              }
              return const LoadingPage();
            },
          ),
          bottomNavigationBar: (state is! HomeLoaded)
              ? null
              : NavigationWidget(
                  type: state.type,
                  onClick: (type) {
                    context.read<HomeCubit>().setBody(type);
                  },
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: (state is HomeLoaded &&
                  (state.type == HomeBodyType.home ||
                      state.type == HomeBodyType.order))
              ? BlocBuilder<CartCubit, CartState>(
                  builder: (context, cartState) {
                    if (cartState is CartLoaded) {
                      return FloatingActionWidget(
                        addressName: cartState.addressName,
                        type: cartState.categoryId,
                        amount: cartState.amount,
                        cost: cartState.calculateCost,
                        expanded: expanded,
                        onClick: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (ctx) => MethodOrderBottomSheet(
                              type: cartState.categoryId,
                              addressName: cartState.addressName,
                              login: context.read<HomeCubit>().login,
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                )
              : null,
        );
      },
    );
  }
}
