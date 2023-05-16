import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/address_model.dart';

import '../../../business_logic/cubits/address_cubit.dart';
import '../../../business_logic/repositories/setting_repository.dart';
import '../../../business_logic/states/address_state.dart';
import '../../../data/repositories/api/setting_api_repository.dart';
import '../../pages/loading_page.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';
import '../../widgets/address/address_add_widget.dart';
import '../../widgets/address/address_widget.dart';
import 'address_detail_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: fontXL,
          ),
        ),
        title: Text(
          txtSavedAddress,
          style: TextStyle(
            fontSize: fontLG,
            color: Colors.black.withAlpha(200),
          ),
        ),
      ),
      body: RepositoryProvider<SettingRepository>(
        create: (context) => SettingApiRepository(),
        child: BlocProvider<AddressCubit>(
          create: (context) => AddressCubit(
            repository: RepositoryProvider.of<SettingRepository>(context),
          ),
          child: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case AddressInitial:
                  return const SizedBox();
                case AddressLoading:
                  return const LoadingPage();
                case AddressLoaded:
                  state as AddressLoaded;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var address in state.defaultAddresses)
                          AddressWidget(
                            model: address,
                            onClick: () {
                              _toDetail(context, address, true);
                            },
                          ),
                        AddressAddWidget(
                          onClick: () {
                            _toDetail(context, null);
                          },
                        ),
                        for (var address in state.otherAddresses)
                          AddressWidget(
                            model: address,
                            onClick: () {
                              _toDetail(context, address);
                            },
                          ),
                      ],
                    ),
                  );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void _toDetail(
    BuildContext context,
    AddressModel? address, [
    bool isDefault = false,
  ]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return BlocProvider.value(
            value: BlocProvider.of<AddressCubit>(context),
            child: AddressDetailScreen(
              model: address,
              isDefault: isDefault,
            ),
          );
        },
      ),
    );
  }
}
