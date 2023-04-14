import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/states/home_state.dart';
import 'package:member_app/data/models/order_model.dart';

import 'reorder_state.dart';

class ReOrderCubit extends Cubit<ReOrderState> {
  ReOrderCubit()
      : super(
          ReOrderInitial(),
        );

  void loadReOrder() {
    emit(ReOrderLoading());
    emit(
      ReOrderLoaded(
        orders: [
          OrderModel(
            title: 'Trà sữa bạc hà, thạch phô mai',
            icon:
                'https://www.drench-design.com/wp-content/uploads/2018/10/coffeetype2.png',
            type: OrderType.delivery,
            address: '125/42/14 Bùi Đình Tuý, Bình Thạnh',
            dateTime: DateTime.now(),
            price: 25000,
          ),
          OrderModel(
            title: 'Trà sữa thái xanh truyền thống',
            icon:
            'https://ouch-cdn2.icons8.com/hEsAT1ipu3qqNYKnftbZ2uAw8IjsU5Xe1laLSCfvuL8/rs:fit:256:256/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvODc4/LzRlMGVhNmJiLWY4/ODgtNDc5OS04YTZl/LWM4YTNkMGRmYjc4/OS5zdmc.png',
            type: OrderType.takeOut,
            address: '419 Ngô Gia Tự, Quận 10',
            dateTime: DateTime.now(),
            price: 28000,
          ),
        ],
      ),
    );
  }

  void setReOrder(HomeBodyType type) async {}
}
