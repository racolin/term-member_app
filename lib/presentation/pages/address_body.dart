import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/screens/address_detail_screen.dart';

import '../../presentation/res/dimen/dimens.dart';
import '../../business_logic/repositories/setting_repository.dart';
import '../../business_logic/cubits/address_cubit.dart';
import '../../business_logic/states/address_state.dart';
import '../../data/repositories/setting_api_repository.dart';
import '../../presentation/pages/loading_page.dart';
import '../../data/models/address_model.dart';
import '../widgets/app_icon_widget.dart';

class AddressBody extends StatelessWidget {
  final bool returnable;

  const AddressBody({
    Key? key,
    required this.returnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SettingRepository>(
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
                        _getAddress(context, address),
                      _getAddAddress(context),
                      for (var address in state.otherAddresses)
                        _getAddress(context, address),
                    ],
                  ),
                );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _getAddAddress(BuildContext context) {
    return ListTile(
      shape: const Border(
        bottom: BorderSide(color: Colors.black26, width: 0.5),
      ),
      onTap: () {
        _toDetail(context, null);
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIconWidget(
            codePoint: Icons.add.codePoint,
            defaultCodePoint: Icons.bookmark_border_outlined.codePoint,
            size: fontXL,
            color: Colors.black87,
          ),
        ],
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceSM),
        child: Text(
          'Thêm địa chỉ mới',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spaceSM,
      ),
      minVerticalPadding: 0,
      dense: true,
    );
  }

  /// Hiện tại đang chạy theo trả về bool thì reload state
  /// Có thể khi lưu thì back về với AddressModel chèn vô State
  Future<bool> _toDetail(BuildContext context, [AddressModel? model]) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddressDetailScreen(
            model: model,
          );
        },
      ),
    );

    return result is bool && result;
  }

  Widget _getAddress(BuildContext context, AddressModel model) {
    return ListTile(
      onTap: () {
        if (returnable) {
          Navigator.pop(context, model);
        } else {
          _toDetail(context, model);
        }
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIconWidget(
            codePoint: model.icon,
            defaultCodePoint: Icons.bookmark_border_outlined.codePoint,
            size: fontXL,
            color: Colors.black87,
          ),
        ],
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: spaceSM),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26, width: 0.5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: spaceXS,
            ),
            Text(
              model.address,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: spaceXXS,
            ),
            Text(
              '${model.receiver} ${model.phone}',
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spaceSM,
      ),
      minVerticalPadding: 0,
      dense: true,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              _toDetail(context, model);
            },
            icon: AppIconWidget(
              size: fontXL,
              color: Colors.orange,
              codePoint: Icons.edit_note_outlined.codePoint,
            ),
          ),
        ],
      ),
    );
  }
}
