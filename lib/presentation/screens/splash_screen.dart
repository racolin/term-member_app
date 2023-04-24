import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(dimXL / 2),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor,
                  BlendMode.color,
                ),
                child: Image.asset(
                  'assets/images/icon_default.png',
                  height: dimXL,
                  width: dimXL,
                ),
              ),
            ),
            const SizedBox(height: spaceXXL),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.color,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                width: 2 * dimXXL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
