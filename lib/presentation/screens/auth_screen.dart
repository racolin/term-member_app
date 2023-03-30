import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                context.read<AuthCubit>().login('phantrungtin01@gmail.com');
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<AuthCubit>().register('phantrungtin01@gmail.com');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
