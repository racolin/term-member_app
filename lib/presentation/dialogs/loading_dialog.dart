import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../res/dimen/dimens.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(height: spaceMD),
          CupertinoActivityIndicator(),
          SizedBox(height: spaceSM),
          Text(
            txtLoading,
            style: TextStyle(
              color: Colors.black87,
              fontSize: fontMD,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: spaceMD),
        ],
      ),
    );
  }
}
