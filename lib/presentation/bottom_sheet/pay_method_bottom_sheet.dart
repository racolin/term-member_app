import 'package:flutter/material.dart';
import 'package:member_app/data/models/cart_model.dart';

import '../../data/models/pay_method_model.dart';

class PayMethodBottomSheet extends StatelessWidget {
  final DeliveryType? deliveryType;
  final PayMethodType selected;

  const PayMethodBottomSheet({
    Key? key,
    required this.deliveryType,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var methods = [
      PayMethod(
        name: 'Momo',
        type: PayMethodType.momo,
        image: 'https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png',
      ),
      PayMethod(
        name: 'Tiền mặt',
        type: PayMethodType.cash,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxVK2Ldio3wbcompe76GCOvyURqeR96FG-Ow&usqp=CAU',
      ),
    ];

    return Container(
      margin: const EdgeInsets.only(top: 56),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            _getTitle(context),
            Container(
              color: Colors.grey.withAlpha(30),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: const Text(
                // 'Vui lòng chọn phương thức thanh toán phù hợp cho đơn hàng của bạn.',
                'Hiện tại chúng tôi chỉ cho phép thanh toán bằng tiền mặt.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            _getMethods(context, methods, deliveryType, selected),
            Container(
              color: Colors.grey.withAlpha(30),
              height: 48,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTitle(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 55,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: const Text(
                'Phương thức thanh toán',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close_sharp,
                  size: 22,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _getMethods(
    BuildContext context,
    List<PayMethod> methods,
    DeliveryType? deliveryType,
    PayMethodType? selected,
  ) {
    return Column(
      children: methods
          .map((method) => _getMethod(
                context,
                method,
                methods[selected == PayMethodType.cash ? 1 : 0],
                deliveryType == DeliveryType.takeOut
                    ? false
                    : method.type == PayMethodType.cash,
              ))
          .toList(),
    );
  }

  Widget _getMethod(
    BuildContext context,
    PayMethod method,
    PayMethod selected,
    bool isDisabled,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 0.8,
              child: Radio(
                value: method.type,
                groupValue: selected.type,
                onChanged: isDisabled ? null : (type) {
                  Navigator.pop(context, method);
                },
              ),
            ),
            Image.network(
              method.image,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              method.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const Divider(height: 1),
      ],
    );
  }
}
