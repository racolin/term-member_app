import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../data/models/address_model.dart';

class AddressDetailScreen extends StatefulWidget {
  final AddressModel? model;

  const AddressDetailScreen({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  State<AddressDetailScreen> createState() => _AddressDetailScreenState();
}

class _AddressDetailScreenState extends State<AddressDetailScreen> {
  late AddressModel? model;

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          model == null ? 'Thêm địa chỉ ' : 'Chỉnh sửa địa chỉ ',
          style: const TextStyle(fontSize: 16),
        ),
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: spaceSM,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getField(
                          'Tên địa chỉ',
                          model?.name ?? '',
                          'Nhà / Cơ quan / Gym / ...',
                          false,
                          model?.icon == null,
                        ),
                        _getField(
                          'Địa chỉ',
                          model?.address ?? '',
                          'Nhập địa chỉ',
                          true,
                        ),
                        // _getAddressField(model?.address ?? ''),
                        _getField(
                          'Hướng dẫn cụ thể(toà nhà, số tầng, cổng,...)',
                          model?.note ?? '',
                          'Toà nhà, số tầng',
                          false,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spaceSM,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getField(
                          'Tên người nhận',
                          model?.receiver ?? '',
                          'Tên người nhận',
                          true,
                        ),
                        _getField(
                          'Số điện thoại',
                          model?.phone ?? '',
                          'Số điện thoại người nhận',
                          true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spaceSM,
                    ),
                    _getRemove(),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              const Divider(height: 1),
              Container(
                padding: const EdgeInsets.only(
                  right: spaceLG,
                  bottom: spaceXXL,
                  left: spaceLG,
                  top: spaceMD,
                ),
                height: dimXL,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: (model?.address.isEmpty ?? false) ? null : () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor.withGreen(180)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(spaceXS),
                      ),
                    ),
                  ),
                  child: const Text(
                    txtSave,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: fontMD,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getField(
    String title,
    String value,
    String hint,
    bool isForce, [
    bool enable = true,
  ]) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: spaceSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: spaceXS),
          _getTitle(title, isForce),
          const SizedBox(height: spaceXS),
          Container(
            decoration: BoxDecoration(
              color: enable ? Colors.white : Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.circular(spaceXS),
            ),
            child: TextFormField(
              enabled: enable,
              initialValue: value,
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
                  hintStyle: const TextStyle(fontSize: fontMD)),
            ),
          ),
          const SizedBox(height: spaceXS),
        ],
      ),
    );
  }

  Widget _getTitle(String title, bool isForce) {
    return Text.rich(
      TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: fontMD,
          fontWeight: FontWeight.w600,
        ),
        children: [
          if (isForce)
            const TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: fontMD,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  // Widget _getAddressField(String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const SizedBox(height: 8),
  //         _getTitle('Địa chỉ', true),
  //         const SizedBox(height: 8),
  //         Container(
  //           width: double.maxFinite,
  //           padding: const EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: value.isEmpty
  //               ? const SizedBox(height: 20)
  //               : Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 value.split(',').first,
  //                 style: const TextStyle(
  //                   fontSize: 17,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Text(
  //                 value,
  //                 style: const TextStyle(height: 1.5),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //       ],
  //     ),
  //   );
  // }

  // Widget _getAddressField(String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const SizedBox(height: 8),
  //         _getTitle('Địa chỉ', true),
  //         const SizedBox(height: 8),
  //         Container(
  //           width: double.maxFinite,
  //           padding: const EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: value.isEmpty
  //               ? const SizedBox(height: 20)
  //               : Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 value.split(',').first,
  //                 style: const TextStyle(
  //                   fontSize: 17,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Text(
  //                 value,
  //                 style: const TextStyle(height: 1.5),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //       ],
  //     ),
  //   );
  // }

  Widget _getRemove() {
    return InkWell(
      onTap: () {},
      child: Ink(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(spaceSM),
          child: Row(
            children: const [
              Icon(
                Icons.delete,
                color: Colors.red,
                size: fontLG,
              ),
              SizedBox(width: spaceSM),
              Text(
                'Xoá địa chỉ này',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: fontMD),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
