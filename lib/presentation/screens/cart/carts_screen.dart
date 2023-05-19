import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/cart/cart_widget.dart';

import '../../../business_logic/cubits/cart_detail_cubit.dart';
import '../../../business_logic/cubits/carts_cubit.dart';
import '../../../business_logic/repositories/cart_repository.dart';
import '../../../business_logic/states/carts_state.dart';
import '../../pages/alert_page.dart';
import 'cart_detail_screen.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  var selected = 0;
  final ScrollController _controller = ScrollController();
  final listPosition = <double>[0, 0, 0];

  @override
  void initState() {
    _controller.addListener(() {
      listPosition[selected] = _controller.position.pixels;
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
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context.read<CartsCubit>().tap(
                                    state.statuses[index].id,
                                  );
                              setState(() {
                                selected = index;
                              });
                              _controller.jumpTo(listPosition[selected]);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withAlpha(
                                  selected == index ? 80 : 20,
                                ),
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
                      state.statuses[selected].id == 'done',
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

  Widget _getCarts(List<CartModel> carts, bool isSuccess) {
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
    return ListView.separated(
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Divider(
          height: 1,
        ),
      ),
      controller: _controller,
      itemBuilder: (context, index) => CartWidget(
        model: carts[index],
        onClick: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<CartDetailCubit>(
                      create: (context) => CartDetailCubit(
                        repository: RepositoryProvider.of<CartRepository>(
                          context,
                        ),
                        id: carts[index].id,
                      ),
                    ),
                    BlocProvider<CartsCubit>.value(
                      value: RepositoryProvider.of<CartsCubit>(
                        context,
                      ),
                    ),
                  ],
                  child: const CartDetailScreen(),
                );
              },
            ),
          );
        },
        isSuccess: isSuccess,
      ),
      itemCount: carts.length,
    );
  }
}
