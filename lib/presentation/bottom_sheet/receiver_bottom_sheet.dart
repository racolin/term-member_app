import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/repositories/store_repository.dart';
import 'package:member_app/data/models/address_model.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/geolocator_cubit.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/cubits/store_cubit.dart';
import '../../data/models/store_model.dart';
import '../../data/repositories/api/store_api_repository.dart';
import '../../presentation/res/strings/values.dart';
import '../../data/models/cart_model.dart';
import '../../supports/convert.dart';
import '../res/dimen/dimens.dart';
import '../screens/store_search_screen.dart';

class ReceiverBottomSheet extends StatefulWidget {
  final String? name;
  final String? phone;

  const ReceiverBottomSheet({
    Key? key,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  State<ReceiverBottomSheet> createState() => _ReceiverBottomSheetState();
}

class _ReceiverBottomSheetState extends State<ReceiverBottomSheet> {
  String? name;
  String? phone;

  @override
  void initState() {
    name = widget.name;
    phone = widget.phone?.replaceFirst('+84', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Người nhận',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          const SizedBox(height: spaceSM),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: spaceMD,
            ),
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: spaceSM),
                  padding: const EdgeInsets.all(spaceSM),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(spaceXS),
                    border: Border.all(color: Colors.black54, width: 0.5),
                  ),
                  child: TextFormField(
                    initialValue: name,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      name = value;
                    },
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  left: spaceSM,
                  child: Text(
                    'Tên',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: spaceMD,
            ),
            child: Stack(
              children: [
                Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: spaceSM),
                  padding: const EdgeInsets.all(spaceSM),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(spaceXS),
                    border: Border.all(color: Colors.black54, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: spaceXXS,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/vn.jpeg',
                        ),
                        radius: spaceXS,
                      ),
                      const SizedBox(
                        width: spaceXXS,
                      ),
                      Text(
                        '+84',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: spaceXS,
                      ),
                      Container(
                        width: 1,
                        color: Colors.black54,
                        height: double.maxFinite,
                      ),
                      const SizedBox(
                        width: spaceXS,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: phone,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 2,
                  left: spaceSM,
                  child: Text(
                    'Số điện thoại',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<CartCubit>()
                  .setReceiver(name ?? '', phone == null ? '' : '+84$phone');
              Navigator.pop(context);
            },
            child: const Text(
              'Xong',
            ),
          ),
          const SizedBox(height: dimMD),
        ],
      ),
    );
  }
}
