import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../business_logic/cubits/carts_cubit.dart';
import '../../business_logic/states/carts_state.dart';
import '../../supports/convert.dart';
import '../pages/alert_page.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  var selected = 0;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          // atTop
        } else {
          var state = context.read<CartsCubit>().state;
          if (state is CartsLoaded) {
            String id = state.statuses[selected].id;
            if (context.read<CartsCubit>().hasNext(id)) {
              context.read<CartsCubit>().loadMore(id);
            }
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lịch sử đơn hàng',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.orange.withAlpha(50),
        elevation: 0,
        leading: IconButton(
          splashRadius: 28,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: BlocBuilder<CartsCubit, CartsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartsLoaded:
              state as CartsLoaded;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    children: [
                      for (var index = 0;
                          index < state.statuses.length;
                          index++)
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context
                                  .read<CartsCubit>()
                                  .tap(state.statuses[index].id);
                              setState(() {
                                selected = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.orange
                                    .withAlpha(selected == index ? 80 : 20),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                state.statuses[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  Expanded(
                    child: _getCarts(
                      state.listCarts[state.statuses[selected].id]?.list ?? [],
                    ),
                  ),
                ],
              );
          }
          return Container();
        },
      ),
    );
  }

  Widget _getCarts(List<CartModel> carts) {
    if (carts.isEmpty) {
      return AlertPage(
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(dimXL / 2),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.orange,
              BlendMode.color,
            ),
            child: Image.asset(
              'assets/images/icon_default.png',
              width: dimXL,
              height: dimXL,
            ),
          ),
        ),
        type: AlertType.warning,
        description: 'Chưa có dữ liệu',
      );
    }
    return ListView.builder(
      controller: _controller,
      itemBuilder: (context, index) => _getCart(carts[index]),
      itemCount: carts.length,
    );
  }

  Widget _getCart(CartModel cart) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              cart.categoryId.image,
              height: 32,
              width: 32,
            ),
          ),
          title: Text(
            cart.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                dateToString(cart.time, 'HH:MM - dd/MM/yyyy'),
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              if (cart.rate == null)
                const Text(
                  'Chưa đánh giá',
                  style: TextStyle(fontSize: 12),
                )
              else ...[
                Text(
                  cart.rate.toString(),
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
            numberToCurrency(cart.cost, 'đ'),
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Divider(),
        ),
      ],
    );
  }
}
