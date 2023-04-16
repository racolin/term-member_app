import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/repositories/member_repository.dart';
import 'package:member_app/data/repositories/member_api_repository.dart';

import '../business_logic/blocs/interval/interval_bloc.dart';
import '../business_logic/cubits/app_bar_cubit.dart';
import '../business_logic/cubits/card_cubit.dart';
import '../business_logic/cubits/cart_cubit.dart';
import '../business_logic/cubits/category_product_cubit.dart';
import '../business_logic/cubits/category_scroll_cubit.dart';
import '../business_logic/cubits/home_cubit.dart';
import '../business_logic/cubits/news_cubit.dart';
import '../business_logic/cubits/product_cubit.dart';
import '../business_logic/cubits/promotion_cubit.dart';
import '../business_logic/cubits/reorder_cubit.dart';
import '../business_logic/cubits/suggest_product_cubit.dart';
import '../business_logic/cubits/voucher_cubit.dart';
import '../presentation/screens/auth_screen.dart';
import '../presentation/screens/home_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateAppRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => MemberApiRepository(),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => HomeCubit(),
                  ),
                  BlocProvider(
                    create: (context) => AppBarCubit(
                      repository: RepositoryProvider.of<MemberApiRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CardCubit(
                      repository: RepositoryProvider.of<MemberApiRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => ReOrderCubit(),
                  ),
                  BlocProvider(
                    create: (context) => SuggestProductCubit(),
                  ),
                  BlocProvider(
                    create: (context) => NewsCubit(),
                  ),
                  BlocProvider(
                    create: (context) => ProductCubit(),
                  ),
                  BlocProvider(
                    create: (context) => CategoryProductCubit(),
                  ),
                  BlocProvider(
                    create: (context) => CategoryScrollCubit(),
                  ),
                  BlocProvider(
                    create: (context) => StoreBloc(),
                  ),
                  BlocProvider(
                    create: (context) => PromotionCubit(),
                  ),
                  BlocProvider(
                    create: (context) => VoucherCubit(),
                  ),
                  BlocProvider(
                    create: (context) => CartCubit(),
                  ),
                ],
                child: const HomeScreen(),
              ),
            );
          },
        );
      case '/auth':
        return MaterialPageRoute(
          builder: (context) {
            return const AuthScreen();
          },
        );
    }
    return null;
  }
}
