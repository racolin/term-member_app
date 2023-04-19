import 'package:flutter/material.dart';

import '../../../data/models/store_model.dart';
import '../../res/dimen/dimens.dart';
import 'store_item_widget.dart';

class StoresWidget extends StatelessWidget {
  final List<StoreModel> list;
  final Function(StoreModel) onClickItem;

  const StoresWidget({
    Key? key,
    required this.list,
    required this.onClickItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => StoreItemWidget(
        store: list[index],
        onClick: onClickItem,
      ),
      padding: const EdgeInsets.only(bottom: dimLG),
      itemCount: list.length,
    );
  }
}
