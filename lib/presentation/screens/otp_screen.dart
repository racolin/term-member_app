import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/supports/convert.dart';

import '../../business_logic/cubits/auth_cubit.dart';
import '../dialogs/app_dialog.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = '';
  int countDown =  10 * 60;
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countDown == 0) {
          timer.cancel();
          Navigator.pop(context);
        } else {
          countDown--;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.all(spaceMD),
        margin: const EdgeInsets.only(top: 56),
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
              height: dimSM,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Nhập OTP để xác thực',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: spaceMD,
            ),
            TextField(
              maxLength: 6,
              keyboardType: TextInputType.phone,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 56,
                    letterSpacing: 20,
                    fontWeight: FontWeight.w600,
                  ),
              onChanged: (value) {
                _otp = value;
              },
              showCursor: false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(spaceXS),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 0.5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(spaceXS),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: dimXXS,
            ),
            Text('Thời hạn của otp còn ${secondToTime(countDown)} giây.'),
            const SizedBox(
              height: spaceXL,
            ),
            const Text('Sau thời gian này, ứng dùng sẽ quay lại trang trước.'),
            const SizedBox(
              height: dimXS,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  var message = await context.read<AuthCubit>().otpCheck(
                    _otp,
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
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouter.home,
                            (route) => false,
                      );
                    }
                  }
                },
                child: Text(
                  txtLogIn,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
