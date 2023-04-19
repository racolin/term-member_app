import 'package:flutter/material.dart';

import '../../presentation/res/strings/values.dart';
import '../pages/address_body.dart';
import '../res/dimen/dimens.dart';

class AddressSelectScreen extends StatelessWidget {
  const AddressSelectScreen({Key? key}) : super(key: key);

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
          txtSelectAddress,
          style: TextStyle(
            fontSize: fontLG,
            color: Colors.black.withAlpha(200),
          ),
        ),
      ),
      body: const AddressBody(returnable: true),
    );
  }
}
