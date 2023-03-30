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
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: AppRouter.onGenerateAppRoute,
      ),
    );
  }
}
