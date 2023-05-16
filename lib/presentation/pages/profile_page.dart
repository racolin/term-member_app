import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/profile_cubit.dart';
import 'package:member_app/data/models/profile_model.dart';
import 'package:member_app/supports/check.dart';

import '../../exception/app_message.dart';
import '../../supports/convert.dart';
import '../dialogs/app_dialog.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class ProfilePage extends StatefulWidget {
  final ProfileModel model;

  const ProfilePage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? firstName;
  String? lastName;

  @override
  void initState() {
    firstName = widget.model.firstName;
    lastName = widget.model.lastName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: spaceMD,
        ),
        Stack(
          children: [
            Container(
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: spaceSM),
              padding: const EdgeInsets.all(spaceSM),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
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
                    child: Text(
                      widget.model.phone,
                      style: Theme.of(context).textTheme.bodyLarge,
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
                      color: Colors.grey,
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
                    width: double.maxFinite,
                    height: 48,
                    margin: const EdgeInsets.symmetric(vertical: spaceSM),
                    padding: const EdgeInsets.all(spaceSM),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spaceXS),
                      border: Border.all(color: Colors.black54, width: 0.5),
                    ),
                    child: TextFormField(
                      initialValue: widget.model.firstName,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        firstName = value;
                      },
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
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(vertical: spaceSM),
                    padding: const EdgeInsets.all(spaceSM),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spaceXS),
                      border: Border.all(color: Colors.black54, width: 0.5),
                    ),
                    child: TextFormField(
                      initialValue: widget.model.lastName,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        lastName = value;
                      },
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
        Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: spaceSM),
                  padding: const EdgeInsets.only(
                    top: spaceXS,
                    bottom: spaceXS,
                    left: spaceXS,
                    right: spaceLG + 2 * spaceSM,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(spaceXS),
                    border: Border.all(color: Colors.black54, width: 0.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(spaceXXS),
                        child: Container(
                          color: Colors.blue,
                          child: Image.asset(
                            widget.model.gender == 0
                                ? 'assets/images/men.png'
                                : 'assets/images/women.png',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
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
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                  ),
                ),
                Positioned(
                  top: spaceSM,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
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
                      Icons.keyboard_double_arrow_right_outlined,
                      color: Colors.white,
                      size: fontLG,
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
                    child: Text(
                      dateToString(widget.model.dob, 'dd/MM/yyyy'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: spaceSM,
                    child: Text(
                      'Ngày sinh',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                  ),
                  Positioned(
                    top: spaceSM,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
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
                ],
              ),
            ),
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
              if (verifyField(firstName) && verifyField(lastName)) {
                var message = await context.read<ProfileCubit>().updateProfile(
                      lastName: lastName!,
                      firstName: firstName!,
                    );

                if (mounted) {
                  if (message == null) {
                    FocusScope.of(context).unfocus();
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => AppDialog(
                        message: AppMessage(
                          type: AppMessageType.success,
                          title: txtSuccessTitle,
                          content: 'Bạn đã cập nhật thông tin thành công!',
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(txtConfirm),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => AppDialog(
                        message: message,
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(txtConfirm),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                }
              } else {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => AppDialog(
                    message: AppMessage(
                      type: AppMessageType.failure,
                      title: txtFailureTitle,
                      content: 'Bạn cần nhập đầy đủ thông tin bắt buộc!',
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(txtConfirm),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text(
              txtUpdate,
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
