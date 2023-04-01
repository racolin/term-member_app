import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/card_cubit.dart';
import 'package:member_app/business_logic/cubits/category_product_cubit.dart';
import 'package:member_app/business_logic/cubits/news_cubit.dart';
import 'package:member_app/business_logic/cubits/product_cubit.dart';
import 'package:member_app/business_logic/cubits/reorder_cubit.dart';
import 'package:member_app/business_logic/cubits/slider_cubit.dart';
import 'package:member_app/business_logic/cubits/suggest_product_cubit.dart';
import 'package:member_app/presentation/pages/promotion_body.dart';
import 'package:member_app/presentation/pages/home_body.dart';
import 'package:member_app/presentation/pages/order_body.dart';
import 'package:member_app/presentation/pages/other_body.dart';
import 'package:member_app/presentation/pages/store_body.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/widgets/app_bar_widget.dart';
import 'package:member_app/presentation/widgets/floating_action_widget.dart';

import '../../business_logic/cubits/home_cubit.dart';
import '../../business_logic/cubits/home_state.dart';
import '../widgets/navigation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<AppBarCubit>().loadAppBar();
    context.read<SliderCubit>().loadSlider();
    context.read<CardCubit>().loadCard();
    context.read<ReOrderCubit>().loadReOrder();
    context.read<SuggestProductCubit>().loadSuggestProduct();
    context.read<NewsCubit>().loadNews();
    context.read<ProductCubit>().loadProducts();
    context.read<CategoryProductCubit>().loadCategories();
    super.initState();
  }

  Widget _getBody(HomeBodyType type) {
    Widget body;
    switch (type) {
      case HomeBodyType.home:
        body = const HomeBody();
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: AppBarWidget(),
        body: _getBody(state.homeBodyType),
        bottomNavigationBar: const NavigationWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionWidget(
          onClick: () {},
        ),
      ),
    );
  }
}
