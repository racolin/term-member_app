import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/profile_cubit.dart';

import '../../business_logic/states/profile_state.dart';
import '../pages/profile_page.dart';
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
                return ProfilePage(
                  model: (state as ProfileLoaded).profile,
                );
              case ProfileFailure:
            }
            return Container();
          },
        ),
      ),
    );
  }
}
