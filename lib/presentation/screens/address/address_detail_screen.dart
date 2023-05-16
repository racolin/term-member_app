import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/address_cubit.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/address/address_field.dart';

import '../../../data/models/address_model.dart';

class AddressDetailScreen extends StatefulWidget {
  final AddressModel? model;
  final bool isDefault;

  const AddressDetailScreen({
    Key? key,
    required this.model,
    this.isDefault = false,
  }) : super(key: key);

  @override
  State<AddressDetailScreen> createState() => _AddressDetailScreenState();
}

class _AddressDetailScreenState extends State<AddressDetailScreen> {
  String? name;
  String? address;
  String? note;
  String? receiver;
  String? phone;

  @override
  void initState() {
    name = widget.model?.name;
    address = widget.model?.address;
    note = widget.model?.note;
    receiver = widget.model?.receiver;
    phone = widget.model?.phone;
    super.initState();
  }

  bool verifyField(String? field) {
    return field != null && field.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.model == null ? 'Thêm địa chỉ ' : 'Chỉnh sửa địa chỉ ',
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
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        top: spaceXXS,
                        bottom: spaceXS,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AddressField(
                            title: 'Tên địa chỉ',
                            value: name,
                            hint: 'Nhà / Cơ quan / Gym / ...',
                            isForce: true,
                            onChanged: (value) {
                              name = value;
                            },
                            enable: !widget.isDefault,
                          ),
                          AddressField(
                            title: 'Địa chỉ',
                            value: address,
                            hint: 'Nhập địa chỉ',
                            isForce: true,
                            onChanged: (value) {
                              address = value;
                            },
                            maxLines: null,
                          ),
                          AddressField(
                            title:
                                'Hướng dẫn cụ thể(toà nhà, số tầng, cổng,...)',
                            value: note,
                            hint: 'Toà nhà, số tầng',
                            isForce: false,
                            onChanged: (value) {
                              note = value;
                            },
                            maxLines: null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: spaceSM,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        top: spaceXXS,
                        bottom: spaceXS,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AddressField(
                            title: 'Tên người nhận',
                            value: receiver,
                            hint: 'Tên người nhận',
                            isForce: true,
                            onChanged: (value) {
                              receiver = value;
                            },
                          ),
                          AddressField(
                            title: 'Số điện thoại',
                            value: phone,
                            hint: 'Số điện thoại người nhận',
                            isForce: true,
                            onChanged: (value) {
                              phone = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: spaceSM,
                    ),
                    if (widget.model != null && !widget.isDefault)
                      InkWell(
                        onTap: () async {
                          var message =
                              await context.read<AddressCubit>().deleteAddress(
                                    widget.model!.id,
                                  );

                          if (mounted) {
                            if (message != null) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => AppDialog(
                                  message: message,
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text(txtConfirm),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        },
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
                      )
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
                  onPressed: () async {
                    if (verifyField(name) &&
                        verifyField(address) &&
                        verifyField(receiver) &&
                        verifyField(phone)) {
                      AppMessage? message;
                      if (widget.model == null) {
                        message =
                            await context.read<AddressCubit>().createAddress(
                                  name: name!,
                                  address: address!,
                                  note: note,
                                  receiver: receiver!,
                                  phone: phone!,
                                );
                      } else {
                        message =
                            await context.read<AddressCubit>().updateAddress(
                                  widget.model!.copyWith(
                                    name: name!,
                                    address: address!,
                                    note: note,
                                    receiver: receiver!,
                                    phone: phone!,
                                  ),
                                );
                      }

                      if (mounted) {
                        if (message == null) {
                          Navigator.pop(context);
                        } else {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => AppDialog(
                              message: message!,
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text(txtConfirm),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    } else {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => AppDialog(
                          message: AppMessage(
                            type: AppMessageType.failure,
                            title: txtFailureTitle,
                            content: 'Bạn cần nhập đầy đủ thông tin bắt buộc!',
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text(txtConfirm),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor.withGreen(180),
                    ),
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
}
