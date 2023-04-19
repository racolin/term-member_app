import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubits/store_cubit.dart';
import '../../../business_logic/states/store_state.dart';
import '../../../data/models/store_model.dart';
import '../../res/dimen/dimens.dart';
import 'store_item_widget.dart';

class StoresMainWidget extends StatelessWidget {
  final String searchKey;
  final Function(StoreModel) onClickItem;

  const StoresMainWidget({
    Key? key,
    required this.searchKey,
    required this.onClickItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case StoreInitial:
            return const SizedBox();
          case StoreLoading:
            return const SizedBox();
          case StoreLoaded:
            state as StoreLoaded;
            return ListView.builder(
              itemBuilder: (context, index) => StoreItemWidget(
                store: state.list[index],
                onClick: onClickItem,
              ),
              padding: const EdgeInsets.only(bottom: dimLG),
              itemCount: state.list.length,
            );
        }
        return const SizedBox();
      },
    );
  }
}
