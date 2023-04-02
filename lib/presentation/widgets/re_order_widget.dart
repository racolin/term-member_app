import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../business_logic/cubits/reorder_cubit.dart';
import '../../business_logic/cubits/reorder_state.dart';
import '../res/strings/values.dart';
import '../../supports/convert.dart';
import '../../data/models/order_model.dart';

class ReOrdersWidget extends StatefulWidget {
  const ReOrdersWidget({Key? key}) : super(key: key);

  @override
  State<ReOrdersWidget> createState() => _ReOrdersWidgetState();
}

class _ReOrdersWidgetState extends State<ReOrdersWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReOrderCubit, ReOrderState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ReOrderInitial:
            return const SizedBox();
          case ReOrderLoading:
            return const SizedBox();
          case ReOrderLoaded:
            state as ReOrderLoaded;
            if (state.orders.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: spaceXS,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spaceXS,
                    vertical: spaceXXS,
                  ),
                  child: Text(
                    txtReOrderTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontLG,
                    ),
                  ),
                ),
                for (var order in state.orders) ReorderWidget(order: order),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }
}

class ReorderWidget extends StatelessWidget {
  final OrderModel order;

  const ReorderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          spaceXS,
        ),
      ),
      margin: const EdgeInsets.all(spaceXS),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spaceXS),
        child: ListTile(
          leading: CircleAvatar(
            radius: dimXXS,
            child: Image.network(
              order.icon,
              fit: BoxFit.cover,
            ),
          ),
          trailing: TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.orange,
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spaceLG),
                ),
              ),
              overlayColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor.withOpacity(opaXS),
              ),
            ),
            label: const Text(
              txtReOrder,
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateToString(
                  order.dateTime,
                  'dd/mm/yyyy, HH:MM',
                ),
                style: const TextStyle(
                  fontSize: fontMD,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: spaceXXS,
              ),
              Text(
                order.title,
                style: const TextStyle(
                  fontSize: fontMD,
                  fontWeight: FontWeight.w400,
                ),
                // overflow: TextOverflow.ellipsis,
                // maxLines: 1,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: spaceXXS,
              ),
              Text(
                order.address,
                style: const TextStyle(
                  fontSize: fontMD,
                  fontWeight: FontWeight.w300,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(
                height: spaceXXS,
              ),
              Text(
                numberToCurrency(order.price, 'đ'),
                style: const TextStyle(
                  fontSize: fontMD,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
