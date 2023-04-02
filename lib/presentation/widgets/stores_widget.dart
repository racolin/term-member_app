import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/blocs/store_bloc.dart';

import '../res/dimen/dimens.dart';
import 'store_item_widget.dart';

class StoresWidget extends StatelessWidget {
  final String searchKey;
  final Function(String) onClickItem;

  const StoresWidget({
    Key? key,
    required this.searchKey,
    required this.onClickItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
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
                store: state.stores[index],
                onClick: onClickItem,
              ),
              padding: const EdgeInsets.only(bottom: dimLG),
              itemCount: state.stores.length,
            );
        }
        return const SizedBox();
      },
    );
  }
}
