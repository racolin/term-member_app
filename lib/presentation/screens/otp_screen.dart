import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_app/presentation/app_router.dart';

import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

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
              height: dimXS,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Bạn chưa nhận được OTP? ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Gửi lại OTP!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouter.home,
                    (route) => false,
                    arguments: true,
                  );
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
