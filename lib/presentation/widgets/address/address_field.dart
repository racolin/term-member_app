import 'package:flutter/material.dart';

import '../../widgets/label_field.dart';
import '../../res/dimen/dimens.dart';

class AddressField extends StatelessWidget {
  final String title;
  final String? value;
  final String hint;
  final bool isForce;
  final bool enable;
  final Function(String) onChanged;
  final int? maxLines;

  const AddressField({
    Key? key,
    required this.title,
    required this.value,
    required this.hint,
    required this.isForce,
    required this.onChanged,
    this.maxLines = 1,
    this.enable = true,
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
              color: enable ? Colors.white : Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.circular(spaceXS),
            ),
            child: TextFormField(
              enabled: enable,
              onChanged: onChanged,
              initialValue: value,
              maxLines: maxLines,
              style: const TextStyle(
                fontSize: fontMD,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(spaceXS),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black87,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(spaceXS),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black38,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(spaceXS),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(spaceXS),
                ),
                hintText: hint,
                hintStyle: const TextStyle(fontSize: fontMD),
              ),
            ),
          ),
          const SizedBox(height: spaceXS),
        ],
      ),
    );
  }
}
