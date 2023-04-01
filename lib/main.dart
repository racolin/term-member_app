import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/auth_cubit.dart';
import 'package:member_app/business_logic/cubits/internet_cubit.dart';
import 'package:member_app/presentation/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Member App',
        theme: ThemeData(
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
        initialRoute: '/',
        onGenerateRoute: AppRouter.onGenerateAppRoute,
      ),
    );
  }
}
