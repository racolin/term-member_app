import 'package:flutter/material.dart';

import '../../widgets/label_field.dart';
import '../../res/dimen/dimens.dart';

class AddressFakeField extends StatelessWidget {
  final String title;
  final String? value;
  final String hint;
  final bool isForce;

  const AddressFakeField({
    Key? key,
    required this.title,
    required this.value,
    required this.hint,
    required this.isForce,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: spaceSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: spaceXS),
          LabelField(title: title, isForce: isForce),
          const SizedBox(height: spaceXS),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(spaceXS),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: spaceXS,
                horizontal: spaceXS,
              ),
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: const Border.fromBorderSide(
                  BorderSide(
                    color: Colors.black38,
                    width: 0.5,
                  ),
                ),
                borderRadius: BorderRadius.circular(spaceXS),
              ),
              child: value == null || value!.isEmpty
                  ? Text(
                      hint,
                      style: const TextStyle(fontSize: fontMD),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value!.split("||").first,
                          style: const TextStyle(
                              fontSize: fontLG, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: spaceXXS),
                        Text(
                          value!.split("||").last,
                          style: const TextStyle(fontSize: fontSM),
                        )
                      ],
                    ),
            ),
          ),
          const SizedBox(height: spaceXS),
        ],
      ),
    );
  }
}
