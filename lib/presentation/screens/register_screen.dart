import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/screens/otp_screen.dart';

import '../../business_logic/cubits/auth_cubit.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  String _phone = '';
  String _firstName = '';
  String _lastName = '';
  int _gender = 0;
  int _dob = 0;

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
                      onChanged: (value) {
                        _lastName = value;
                      },
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
                      onChanged: (value) {
                        _firstName = value;
                      },
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
        SpecialInputWidget(
          changeDate: (time) {
            setState(() {
              _dob = time;
            });
          },
          selectGender: (gender) {
            setState(() {
              _gender = gender;
            });
          },
        ),
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
            onPressed: () async {
              var message = await context.read<AuthCubit>().register(
                    phone: _phone,
                    dob: DateTime.fromMillisecondsSinceEpoch(_dob),
                    firstName: _firstName,
                    lastName: _lastName,
                    gender: _gender,
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

class SpecialInputWidget extends StatefulWidget {
  final Function(int) selectGender;
  final Function(int) changeDate;

  const SpecialInputWidget({
    Key? key,
    required this.selectGender,
    required this.changeDate,
  }) : super(key: key);

  @override
  State<SpecialInputWidget> createState() => _SpecialInputWidgetState();
}

class _SpecialInputWidgetState extends State<SpecialInputWidget> {
  bool expand = true;
  int dob = DateTime.now().millisecondsSinceEpoch;
  int gender = 0;

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
                  GestureDetector(
                    onTap: () {
                      widget.selectGender(0);
                      setState(() {
                        gender = 0;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: (!expand && gender != 0) ? 0 : 32,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(spaceXXS),
                        color: gender == 0 ? Colors.blue : Colors.white,
                        image: const DecorationImage(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/men.png'),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.selectGender(1);
                      setState(() {
                        gender = 1;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: (!expand && gender != 1) ? 0 : 32,
                      margin: EdgeInsets.only(left: !expand ? 0 : 8),
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(spaceXXS),
                        color: gender == 1 ? Colors.blue : Colors.white,
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
                child: Text(DateFormat('dd/MM/yyyy')
                    .format(DateTime.fromMillisecondsSinceEpoch(dob))),
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
                                      setState(() {
                                        widget.changeDate(
                                            val.millisecondsSinceEpoch);
                                        dob = val.millisecondsSinceEpoch;
                                        // _chosenDateTime = val;
                                      });
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
