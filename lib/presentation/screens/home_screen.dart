import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
import '../widgets/navigation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _getBody(HomeBodyType type) {
    Widget body;
    switch (type) {
      case HomeBodyType.home:
        body = HomeBody(
          onScroll: () {
            setState(() {
              expanded = !expanded;
            });
          },
        );
        break;
      case HomeBodyType.order:
        body = const OrderBody();
        break;
      case HomeBodyType.store:
        body = const StoreBody();
        break;
      case HomeBodyType.other:
        body = const OtherBody();
        break;
      case HomeBodyType.promotion:
        body = const PromotionBody();
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
                  );
              }
              return const LoadingPage();
            },
          ),
          bottomNavigationBar: const NavigationWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: (state is HomeLoaded &&
                  (state.type == HomeBodyType.home ||
                      state.type == HomeBodyType.order))
              ? FloatingActionWidget(
                  expanded: expanded,
                  onClick: () {},
                )
              : null,
        );
      },
    );
  }
}
