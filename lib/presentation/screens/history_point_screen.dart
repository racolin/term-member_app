import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/cubits/cart_detail_cubit.dart';
import '../../business_logic/cubits/carts_cubit.dart';
import '../../business_logic/cubits/history_point_cubit.dart';
import '../../business_logic/repositories/cart_repository.dart';
import '../../business_logic/states/history_point_state.dart';
import '../../data/models/history_point_model.dart';
import '../../supports/convert.dart';
import '../bottom_sheet/voucher_bottom_sheet.dart';
import 'cart/cart_detail_screen.dart';

class HistoryPointScreen extends StatefulWidget {
  const HistoryPointScreen({Key? key}) : super(key: key);

  @override
  State<HistoryPointScreen> createState() => _HistoryPointScreenState();
}

class _HistoryPointScreenState extends State<HistoryPointScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          // atTop
        } else {
          if (context.read<HistoryPointCubit>().hasNext()) {
            context.read<HistoryPointCubit>().loadMore();
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
          'Lịch sử $txtPointName',
          style: TextStyle(fontSize: 16),
        ),
        // backgroundColor: Colors.orange.withAlpha(50),
        // elevation: 0,
        leading: IconButton(
          splashRadius: 28,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: BlocBuilder<HistoryPointCubit, HistoryPointState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case HistoryPointInitial:
              return const SizedBox();
            case HistoryPointLoading:
              return const LoadingPage();
            case HistoryPointLoaded:
              var list = (state as HistoryPointLoaded).paging.list;
              return ListView.builder(
                controller: _controller,
                padding: const EdgeInsets.only(top: spaceMD, bottom: dimMD),
                itemBuilder: (context, index) => _getHistoryItem(list[index]),
                itemCount: list.length,
              );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _getHistoryItem(HistoryPointModel model) {
    return InkWell(
      onTap: () {
        if (model.targetId == null) {
          return;
        }
        if (model.point >= 0) {
          // showModalBottomSheet(
          //   backgroundColor: Colors.transparent,
          //   isScrollControlled: true,
          //   context: context,
          //   builder: (context) {
          //     return VoucherBottomSheet(voucher: state.listSlider[0]);
          //   },
          // ).then((type) {
          //   // if (type != null &&
          //   //     type is HomeBodyType) {
          //   //   context.read<HomeCubit>().setBody(type);
          //   // }
          // });
        } else {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (ctx) {
          //       return MultiBlocProvider(
          //         providers: [
          //           BlocProvider<CartDetailCubit>(
          //             create: (context) => CartDetailCubit(
          //               repository: RepositoryProvider.of<CartRepository>(
          //                 context,
          //               ),
          //               id: model.targetId,
          //             ),
          //           ),
          //           BlocProvider<CartsCubit>.value(
          //             value: RepositoryProvider.of<CartsCubit>(
          //               context,
          //             ),
          //           ),
          //         ],
          //         child: const CartDetailScreen(),
          //       );
          //     },
          //   ),
          // );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
              bottom: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateToString(model.time, 'HH:mm - dd/MM/yyyy'),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    model.point.toString(),
                    style: TextStyle(
                      color: model.point > 0 ? Colors.green : Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Divider(height: 1),
          ),
        ],
      ),
    );
  }
}
