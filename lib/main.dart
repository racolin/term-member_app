import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/repositories/member_repository.dart';

import '../business_logic/cubits/internet_cubit.dart';
import 'business_logic/cubits/cart_cubit.dart';
import 'business_logic/cubits/cart_template_cubit.dart';
import 'business_logic/cubits/carts_cubit.dart';
import 'business_logic/cubits/product_cubit.dart';
import 'business_logic/repositories/cart_repository.dart';
import 'business_logic/repositories/cart_template_repository.dart';
import 'business_logic/repositories/product_repository.dart';
import 'data/repositories/api/cart_api_repository.dart';
import 'data/repositories/api/cart_template_api_repository.dart';
import 'data/repositories/api/member_api_repository.dart';
import 'data/repositories/api/product_api_repository.dart';
import 'presentation/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductApiRepository(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartApiRepository(),
        ),
        RepositoryProvider<CartTemplateRepository>(
          create: (context) => CartTemplateApiRepository(),
        ),
        RepositoryProvider<MemberRepository>(
          create: (context) => MemberApiRepository(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartApiRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(),
          ),
          BlocProvider<ProductCubit>(
            lazy: false,
            create: (context) => ProductCubit(
              repository: RepositoryProvider.of<ProductRepository>(
                context,
              ),
            ),
          ),
          BlocProvider<CartTemplateCubit>(
            create: (context) => CartTemplateCubit(
              repository: RepositoryProvider.of<CartTemplateRepository>(
                context,
              ),
            ),
          ),
          BlocProvider<CartCubit>(
            lazy: false,
            create: (context) => CartCubit(
              repository: RepositoryProvider.of<CartRepository>(
                context,
              ),
            ),
          ),
          BlocProvider<AppBarCubit>(
            create: (context) => AppBarCubit(
              repository: RepositoryProvider.of<MemberRepository>(
                context,
              ),
            ),
          ),
          BlocProvider<CartsCubit>(
            create: (context) => CartsCubit(
              repository: RepositoryProvider.of<CartRepository>(
                context,
              ),
            ),
          ),
        ],
        child: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            return MaterialApp(
              key: ValueKey(state.type),
              // localizationsDelegates: [LocalizationsDelegate],
              title: 'Member App',
              theme: ThemeData(
                scaffoldBackgroundColor: const Color.fromRGBO(244, 244, 244, 1),
                textTheme: const TextTheme(
                  titleLarge: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.1,
                  ),
                  titleMedium: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.25,
                  ),
                  titleSmall: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.25,
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1.25,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                  bodySmall: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                primarySwatch: const MaterialColor(
                  0xFFFFC375,
                  {
                    50: Color(0xFFFFF4E2),
                    100: Color(0xFFFFE2B6),
                    200: Color(0xFFFFCF87),
                    300: Color(0xFFFFBC58),
                    400: Color(0xFFFFAD37),
                    500: Color(0xFFFF9E22),
                    600: Color(0xFFFB931F),
                    700: Color(0xFFF4841C),
                    800: Color(0xFFEE571A),
                    900: Color(0xFFE45C16),
                  },
                ),
              ),
              initialRoute: state.type == InternetType.loading
                  ? AppRouter.splash
                  : AppRouter.home,
              onGenerateRoute: (settings) {
                return AppRouter.onGenerateAppRoute(
                  settings,
                  context.read<InternetCubit>().hasInternet,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
