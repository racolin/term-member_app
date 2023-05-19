import 'package:flutter/material.dart';
import 'package:member_app/data/models/cart_model.dart';

import '../../../supports/convert.dart';

class CartWidget extends StatelessWidget {
  final CartModel model;
  final VoidCallback? onClick;
  final bool isSuccess;

  const CartWidget({
    Key? key,
    required this.model,
    this.isSuccess = false,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      onTap: onClick,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          model.categoryId.image,
          height: 32,
          width: 32,
        ),
      ),
      title: Text(
        model.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            dateToString(model.time, 'HH:MM - dd/MM/yyyy'),
            style: const TextStyle(fontSize: 12),
          ),
          const Spacer(),
          if (isSuccess)
            if (model.rate == null)
              const Text(
                'Chưa đánh giá',
                style: TextStyle(fontSize: 12),
              )
            else ...[
              Text(
                model.rate.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.orange,
                ),
              ),
              const Icon(
                Icons.star_rate_outlined,
                size: 16,
                color: Colors.orange,
              ),
            ],
        ],
      ),
      trailing: Text(
        numberToCurrency(model.cost, 'đ'),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

