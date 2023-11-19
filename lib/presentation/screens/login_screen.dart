import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/auth_cubit.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/screens/otp_screen.dart';
import 'package:member_app/presentation/screens/register_screen.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 56),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      'assets/images/background_auth.jpg',
                      height: 360,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouter.home,
                            (route) => false,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.grey,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(spaceMD),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: spaceXL,
                    ),
                    Text(
                      txtWelcome,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(
                      height: spaceSM,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      width: 280,
                    ),
                    const SizedBox(
                      height: spaceXXL,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 48,
                          margin: const EdgeInsets.symmetric(vertical: spaceSM),
                          padding: const EdgeInsets.all(spaceSM),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(spaceXS),
                            border:
                                Border.all(color: Colors.black54, width: 0.5),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: spaceXXS,
                              ),
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/vn.jpeg',
                                ),
                                radius: spaceXS,
                              ),
                              const SizedBox(
                                width: spaceXXS,
                              ),
                              Text(
                                '+84',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                width: spaceXS,
                              ),
                              Container(
                                width: 1,
                                color: Colors.black54,
                                height: double.maxFinite,
                              ),
                              const SizedBox(
                                width: spaceXS,
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  onChanged: (value) {
                                    _phone = value;
                                  },
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 2,
                          left: spaceSM,
                          child: Text(
                            'Số điện thoại',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: dimXS,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Nếu chưa có tài khoản? Hãy đăng ký ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return BlocProvider<AuthCubit>.value(
                                    value: BlocProvider.of<AuthCubit>(
                                      context,
                                    ),
                                    child: const RegisterScreen(),
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            'tại đây!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: dimXS,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          var message = await context.read<AuthCubit>().login(
                                _phone,
                              );
                          if (mounted) {
                            if (message != null) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return AppDialog(
                                    message: message,
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text(txtConfirm),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return BlocProvider<AuthCubit>.value(
                                      value: BlocProvider.of<AuthCubit>(
                                        context,
                                      ),
                                      child: const OtpScreen(),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          txtLogIn,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
