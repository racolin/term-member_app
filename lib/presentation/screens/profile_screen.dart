import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/profile_cubit.dart';
import 'package:member_app/supports/convert.dart';

import '../../business_logic/states/profile_state.dart';
import '../../data/models/profile_model.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          txtPersonalInfo,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.orange.withAlpha(50),
        elevation: 0,
        leading: IconButton(
          splashRadius: 28,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceSM),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case ProfileInitial:
              case ProfileLoading:
                return Container();
              case ProfileLoaded:
              return _getInformation((state as ProfileLoaded).profile);
              case ProfileFailure:
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _getInformation(ProfileModel profile) {
    return Column(children: [
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
                  child: Text(profile.phone,
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
                    initialValue: profile.firstName,
                    keyboardType: TextInputType.phone,
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
                    initialValue: profile.lastName,
                    keyboardType: TextInputType.phone,
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
                        child: Image.asset('assets/images/men.png'),
                      ),
                    ),
                    const SizedBox(
                      width: spaceXS,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(spaceXXS),
                      child: Container(
                        color: Colors.blue,
                        child: Image.asset('assets/images/women.png'),
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
                    Icons.keyboard_double_arrow_left_outlined,
                    color: Colors.white,
                    size: fontLG,
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
                  child: Text(
                    dateToString(profile.dob, 'dd/MM/yyyy'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Positioned(
                  top: 2,
                  left: spaceSM,
                  child: Text(
                    'Ngày sinh',
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
                Positioned(
                  top: spaceSM,
                  right: 0,
                  child: Container(
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
          onPressed: () {
          },
          child: Text(
            txtUpdate,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),],);
  }
}
