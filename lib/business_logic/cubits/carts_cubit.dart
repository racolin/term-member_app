import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/paging_model.dart';
import '../../exception/app_message.dart';
import '../../data/models/cart_model.dart';
import '../../exception/app_exception.dart';
import '../repositories/cart_repository.dart';
import '../states/carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final CartRepository _repository;

  CartsCubit({required CartRepository repository})
      : _repository = repository,
        super(CartsInitial()) {
    try {
      _repository.getStatuses().then((statuses) {
        if (statuses.isNotEmpty) {
          _repository
              .getsByStatusId(statusId: statuses[0].id, page: 1, limit: 20)
              .then((map) {
            Map<String, PagingModel<CartModel>> listCarts = {};
            for (var e in statuses) {
              listCarts[e.id] = PagingModel<CartModel>(
                limit: 20,
                list: [],
              );
            }
            listCarts[statuses[0].id]?.next(map.value, map.key);

            emit(
              CartsLoaded(
                listCarts: listCarts,
                statuses: statuses,
              ),
            );
          });
        }
      });
    } on AppException catch (ex) {}
  }

  Future<AppMessage?> loadMore(String id) async {
    if (state is CartsLoaded) {
      var state = this.state as CartsLoaded;
      if (state.listCarts[id]?.hasNext() ?? false) {
        try {
          var list = await _repository.getsByStatusId(
            statusId: id,
            page: state.listCarts[id]!.page,
            limit: state.listCarts[id]!.limit,
          );
          state.listCarts[id]!.next(list.value, list.key);

          emit(state.copyWith(listCarts: state.listCarts));
        } on AppException catch (ex) {
          return ex.message;
        }
      }
    }
    return null;
  }

  bool hasNext(String id) {
    print(id);
    if (state is CartsLoaded) {
      var state = this.state as CartsLoaded;
      return state.listCarts[id]?.hasNext() ?? false;
    }
    return false;
  }

  Future<AppMessage?> tap(String id) async {
    if (state is CartsLoaded) {
      var state = this.state as CartsLoaded;
      var listCart = state.listCarts[id];
      if ((listCart?.list.isEmpty ?? false) && (listCart?.hasNext() ?? false)) {
        return loadMore(id);
      }
      return null;
    }
    return AppMessage(
      type: AppMessageType.failure,
      title: 'Hãy đợi!',
      content: 'Trang đang được tải. Hãy đợi trong giây lát',
    );
  }
}
