import 'package:flutter/material.dart';

import '../../presentation/pages/address_body.dart';
import '../../presentation/res/strings/values.dart';
import '../res/dimen/dimens.dart';

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
      body: const AddressBody(returnable: false),
    );
  }
}
