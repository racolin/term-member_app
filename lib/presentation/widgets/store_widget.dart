import 'package:flutter/material.dart';
import 'package:member_app/data/models/store_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import 'store_item_widget.dart';

class StoresWidget extends StatelessWidget {
  final String searchKey;

  const StoresWidget({
    Key? key,
    required this.searchKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<StoreModel> list = [
      StoreModel(
        id: 'id',
        mainImage: linkUnknownIcon,
        images: [],
        dailyTime: '11/05/2001',
        address: AddressModel(
          street: 'street',
          ward: 'ward',
          district: 'district',
          city: 'city',
          country: 'country',
        ),
        fullAddress: 'fullAddress',
        contact: 'contact',
        brandName: 'brandName',
        distance: '0.1',
      ),
    ];
    return ListView.builder(
      itemBuilder: (context, index) => StoreItemWidget(
        store: list[index],
        onClick: () {},
      ),
      padding: EdgeInsets.zero,
      itemCount: list.length,
    );
  }
}
