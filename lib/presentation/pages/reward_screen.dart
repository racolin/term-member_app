import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../app_router.dart';
import '../res/dimen/dimens.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          txtReward,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(spaceSM),
                padding: const EdgeInsets.symmetric(
                  vertical: spaceSM,
                  horizontal: spaceXL,
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    spaceSM,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: spaceMD),
                    Text(
                      txtReward.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: fontSM,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: spaceMD),
                    const Text(
                      'Với $txtReward',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: fontLG,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: spaceMD),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(dimXL / 2),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.orange,
                          BlendMode.color,
                        ),
                        child: Image.asset(
                          'assets/images/icon_default.png',
                          width: dimXL,
                          height: dimXL,
                        ),
                      ),
                    ),
                    const SizedBox(height: spaceMD),
                    const Text(
                      'Tích $txtPointName dễ dàng - Thăng hạng nhanh hơn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: fontSM + 1,
                      ),
                    ),
                    const SizedBox(height: spaceXXS),
                    const Text(
                      'Mô hình thăng hạng thành viên mới dễ dàng hơn',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spaceMD),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(dimXL / 2),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.orange,
                          BlendMode.color,
                        ),
                        child: Image.asset(
                          'assets/images/image_default.png',
                          width: dimXL,
                          height: dimXL,
                        ),
                      ),
                    ),
                    const SizedBox(height: spaceMD),
                    const Text(
                      'Cửa hàng ưu đãi',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: fontSM + 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spaceXXS),
                    const Text(
                      'Thoải mái đổi $txtPointName để nhận nhiều phần quà cực hấp dẫn',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spaceMD),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(dimXL / 2),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.orange,
                          BlendMode.color,
                        ),
                        child: Image.asset(
                          'assets/images/icon_default.png',
                          width: dimXL,
                          height: dimXL,
                        ),
                      ),
                    ),
                    const SizedBox(height: spaceMD),
                    const Text(
                      'Đặc quyền Kim Cương',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: fontSM + 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spaceXXS),
                    const Text(
                      'Tận hưởng các đặc quyền chỉ dành cho thành viên Kim Cương',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spaceMD),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: spaceSM,
              left: spaceSM,
              right: spaceSM,
              bottom: spaceXXL,
            ),
            color: Colors.white,
            width: double.maxFinite,
            height: dimXL,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceXS),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.auth);
              },
              child: Text(
                'Đăng ký thành viên',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
