import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/screens/otp_screen.dart';

import '../../business_logic/cubits/auth_cubit.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                  'Đăng ký thành viên',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: spaceMD,
            ),
            const RegisterForm(),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  int gender = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: spaceSM),
              padding: const EdgeInsets.all(spaceSM),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(spaceXS),
                border: Border.all(color: Colors.black54, width: 0.5),
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    height: 48,
                    margin: const EdgeInsets.symmetric(vertical: spaceSM),
                    padding: const EdgeInsets.all(spaceSM),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spaceXS),
                      border: Border.all(color: Colors.black54, width: 0.5),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: spaceSM,
                    child: Text(
                      'Họ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: spaceMD),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    height: 48,
                    margin: const EdgeInsets.symmetric(vertical: spaceSM),
                    padding: const EdgeInsets.all(spaceSM),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spaceXS),
                      border: Border.all(color: Colors.black54, width: 0.5),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: spaceSM,
                    child: Text(
                      'Tên',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GenderWidget(
            gender: gender,
            selectGender: (gender) {
              setState(() {
                this.gender = gender;
              });
            }),
        const SizedBox(
          height: dimXS,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Đã có tài khoản? Quay lại ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'đăng nhập!',
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
            },
            child: Text(
              txtRegister,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class GenderWidget extends StatefulWidget {
  final int gender;
  final Function(int) selectGender;

  const GenderWidget({
    Key? key,
    this.gender = 0,
    required this.selectGender,
  }) : super(key: key);

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  bool expand = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: spaceSM),
              padding: const EdgeInsets.only(
                top: spaceXS,
                bottom: spaceXS,
                left: spaceXS,
                right: spaceLG + 2 + 2 * spaceSM,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(spaceXS),
                border: Border.all(color: Colors.black54, width: 0.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      widget.selectGender(0);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: (!expand && widget.gender != 0) ? 0 : 32,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(spaceXXS),
                        color: widget.gender == 0 ? Colors.blue : Colors.white,
                        image: const DecorationImage(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/men.png'),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.selectGender(1);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: (!expand && widget.gender != 1) ? 0 : 32,
                      margin: EdgeInsets.only(left: !expand ? 0 : 8),
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(spaceXXS),
                        color: widget.gender == 1 ? Colors.blue : Colors.white,
                        image: const DecorationImage(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/women.png'),
                        ),
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
                'Giới',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
              ),
            ),
            Positioned(
              top: spaceSM,
              right: 0,
              child: InkWell(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(spaceXS),
                ),
                onTap: () {
                  setState(() {
                    expand = !expand;
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color: Colors.black54,
                      width: 0.5,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(spaceXS),
                      left: Radius.zero,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: spaceSM,
                  ),
                  height: 48,
                  child: Icon(
                    expand
                        ? Icons.keyboard_double_arrow_left_outlined
                        : Icons.keyboard_double_arrow_right_outlined,
                    color: Colors.white,
                    size: fontLG,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: spaceSM,
            //   right: 0,
            //   child: Container(
            //     alignment: AlignmentDirectional.centerEnd,
            //     height: 48,
            //     child: const Icon(
            //       Icons.keyboard_double_arrow_left_outlined,
            //       size: fontMD,
            //     ),
            //   ),
            // ),
          ],
        ),
        const SizedBox(width: spaceMD),
        Expanded(
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: 48,
                margin: const EdgeInsets.symmetric(vertical: spaceSM),
                padding: const EdgeInsets.all(spaceSM),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spaceXS),
                  border: Border.all(color: Colors.black54, width: 0.5),
                ),
              ),
              Positioned(
                top: 2,
                left: spaceSM,
                child: Text(
                  'Ngày sinh',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
              ),
              Positioned(
                top: spaceSM,
                right: 0,
                child: InkWell(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(spaceXS),
                  ),
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (_) {
                        return Container(
                          height: 500,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 400,
                                child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    dateOrder: DatePickerDateOrder.dmy,
                                    initialDateTime: DateTime.now(),
                                    onDateTimeChanged: (val) {
                                      // setState(() {
                                      //   _chosenDateTime = val;
                                      // });
                                    }),
                              ),

                              // Close the modal
                              CupertinoButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Colors.black54,
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(spaceXS),
                        left: Radius.zero,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: spaceSM,
                    ),
                    height: 48,
                    child: const Icon(
                      Icons.ads_click_outlined,
                      color: Colors.white,
                      size: fontLG,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
