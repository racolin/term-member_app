import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/pages/reward_screen.dart';
import 'package:member_app/presentation/screens/address_screen.dart';

import '../../business_logic/cubits/product_scroll_cubit.dart';
import '../business_logic/cubits/auth_cubit.dart';
import '../business_logic/cubits/cart_detail_cubit.dart';
import '../business_logic/cubits/notify_cubit.dart';
import '../business_logic/cubits/profile_cubit.dart';
import '../business_logic/cubits/carts_cubit.dart';
import '../business_logic/cubits/store_cubit.dart';
import '../business_logic/repositories/auth_repository.dart';
import '../business_logic/repositories/cart_repository.dart';
import '../business_logic/repositories/cart_template_repository.dart';
import '../business_logic/repositories/logout_repository.dart';
import '../business_logic/repositories/member_repository.dart';
import '../business_logic/repositories/news_repository.dart';
import '../business_logic/repositories/notify_repository.dart';
import '../business_logic/repositories/product_repository.dart';
import '../business_logic/repositories/promotion_repository.dart';
import '../business_logic/repositories/setting_repository.dart';
import '../business_logic/repositories/store_repository.dart';
import '../business_logic/repositories/voucher_repository.dart';
import '../data/repositories/auth_api_repository.dart';
import '../data/repositories/cart_template_api_repository.dart';
import '../data/repositories/logout_storage_repository.dart';
import '../data/repositories/member_api_repository.dart';
import '../data/repositories/news_api_repository.dart';
import '../data/repositories/notify_api_repository.dart';
import '../data/repositories/product_api_repository.dart';
import '../data/repositories/promotion_api_repository.dart';
import '../data/repositories/setting_api_repository.dart';
import '../data/repositories/store_api_repository.dart';
import '../data/repositories/voucher_api_repository.dart';
import '../business_logic/cubits/app_bar_cubit.dart';
import '../business_logic/cubits/card_cubit.dart';
import '../business_logic/cubits/cart_cubit.dart';
import '../business_logic/cubits/cart_template_cubit.dart';
import '../business_logic/cubits/home_cubit.dart';
import '../business_logic/cubits/news_cubit.dart';
import '../business_logic/cubits/product_cubit.dart';
import '../business_logic/cubits/promotion_cubit.dart';
import '../business_logic/cubits/voucher_cubit.dart';
import '../data/repositories/cart_api_repository.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/home_screen.dart';
import 'screens/address_select_screen.dart';
import 'screens/notify_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String auth = '/auth';
  static const String reward = '/reward';
  static const String address = '/address';
  static const String selectAddress = '/select-address';
  static const String cartDetail = '/cart-detail';
  static const String carts = '/carts';
  static const String profile = '/profile';
  static const String notify = '/notify';

  static Route<dynamic>? onGenerateAppRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) {
            // Sửa provider khi có hoặc ko có mạng ở ngay đây
            // Ví dụ: RepositoryProvider<MemberRepository>(
            //           create: (context) => internet ? MemberApiRepository() : MemberLocalRepository(),
            //        )
            bool login = false;
            login = settings.arguments == true ? true : false;
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<CartRepository>(
                  create: (context) => CartApiRepository(),
                ),
                RepositoryProvider<CartTemplateRepository>(
                  create: (context) => CartTemplateApiRepository(),
                ),
                RepositoryProvider<LogoutRepository>(
                  create: (context) => LogoutStorageRepository(),
                ),
                RepositoryProvider<MemberRepository>(
                  create: (context) => MemberApiRepository(),
                ),
                RepositoryProvider<NewsRepository>(
                  create: (context) => NewsApiRepository(),
                ),
                RepositoryProvider<ProductRepository>(
                  create: (context) => ProductApiRepository(),
                ),
                RepositoryProvider<PromotionRepository>(
                  create: (context) => PromotionApiRepository(),
                ),
                RepositoryProvider<SettingRepository>(
                  create: (context) => SettingApiRepository(),
                ),
                RepositoryProvider<StoreRepository>(
                  create: (context) => StoreApiRepository(),
                ),
                RepositoryProvider<VoucherRepository>(
                  create: (context) => VoucherApiRepository(),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => HomeCubit(login),
                  ),
                  BlocProvider(
                    create: (context) => CartCubit(
                      repository: RepositoryProvider.of<CartRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => AppBarCubit(
                      repository: RepositoryProvider.of<MemberRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CardCubit(
                      repository: RepositoryProvider.of<MemberRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => ProductCubit(
                      repository: RepositoryProvider.of<ProductRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => ProductScrollCubit(),
                  ),
                  BlocProvider(
                    create: (context) => VoucherCubit(
                      repository: RepositoryProvider.of<VoucherRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => PromotionCubit(
                      repository: RepositoryProvider.of<PromotionRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => StoreCubit(
                      repository: RepositoryProvider.of<StoreRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CartTemplateCubit(
                      repository: RepositoryProvider.of<CartTemplateRepository>(
                        context,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => NewsCubit(
                      repository: RepositoryProvider.of<NewsRepository>(
                        context,
                      ),
                    ),
                  ),
                ],
                child: const HomeScreen(),
              ),
            );
          },
        );
      case auth:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<AuthRepository>(
              create: (context) => AuthApiRepository(),
              child: BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(
                  repository: RepositoryProvider.of<AuthRepository>(
                    context,
                  ),
                ),
                child: const LoginScreen(),
              ),
            );
          },
        );
      case reward:
        return MaterialPageRoute(
          builder: (context) {
            return const RewardScreen();
          },
        );
      case address:
        return MaterialPageRoute(
          builder: (context) {
            return const AddressScreen();
          },
        );
      case selectAddress:
        return MaterialPageRoute(
          builder: (context) {
            return const AddressSelectScreen();
          },
        );
      case cartDetail:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<CartRepository>(
              create: (context) => CartApiRepository(),
              child: BlocProvider<CartDetailCubit>(
                create: (context) => CartDetailCubit(
                  repository: RepositoryProvider.of<CartRepository>(
                    context,
                  ),
                  id: (settings.arguments as String),
                ),
                child: const LoginScreen(),
              ),
            );
          },
        );
      case carts:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<CartRepository>(
              create: (context) => CartApiRepository(),
              child: BlocProvider<CartsCubit>(
                create: (context) => CartsCubit(
                  repository: RepositoryProvider.of<CartRepository>(
                    context,
                  ),
                ),
                child: const LoginScreen(),
              ),
            );
          },
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<SettingRepository>(
              create: (context) => SettingApiRepository(),
              child: BlocProvider<ProfileCubit>(
                create: (context) => ProfileCubit(
                  repository: SettingApiRepository(),
                ),
                child: const LoginScreen(),
              ),
            );
          },
        );
      case notify:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<NotifyRepository>(
              create: (context) => NotifyApiRepository(),
              child: BlocProvider<NotifyCubit>(
                create: (context) => NotifyCubit(
                  repository: RepositoryProvider.of<NotifyRepository>(
                    context,
                  ),
                ),
                child: const NotifyScreen(),
              ),
            );
          },
        );
    }
    return null;
  }
}
