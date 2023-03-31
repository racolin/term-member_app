import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/home_cubit.dart';
import 'package:member_app/business_logic/cubits/slider_cubit.dart';
import 'package:member_app/data/data_providers/slider_remote_provider.dart';
import 'package:member_app/presentation/screens/auth_screen.dart';
import 'package:member_app/presentation/screens/home_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateAppRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider(
              create: (context) => SliderRemoteProvider(),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => HomeCubit(),
                  ),
                  BlocProvider(
                    create: (context) => AppBarCubit(),
                  ),
                  BlocProvider(
                    create: (context) => SliderCubit(),
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
