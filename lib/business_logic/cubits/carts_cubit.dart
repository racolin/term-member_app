import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../data/models/cart_detail_model.dart';
import '../../data/models/paging_model.dart';
import 'package:member_app/data/models/response_model.dart';
import '../../exception/app_message.dart';
import '../../data/models/cart_model.dart';
import '../repositories/cart_repository.dart';
import '../states/carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final CartRepository _repository;

  CartsCubit({required CartRepository repository})
      : _repository = repository,
        super(CartsInitial()) {
    reload(index: 0);
  }

  void reload({int index = 0}) {
    emit(CartsLoading());
    _repository.getStatuses().then((res) {
      if (res.type == ResponseModelType.success) {
        var statuses = res.data;
        if (statuses.isNotEmpty) {
          _repository
              .getsByStatusId(statusId: statuses[index].id, page: 1, limit: 10)
              .then((res) {
            if (res.type == ResponseModelType.success) {
              Map<String, PagingModel<CartModel>> listCarts = {};
              for (var e in statuses) {
                listCarts[e.id] = PagingModel<CartModel>(
                  page: 1,
                  limit: 10,
                  list: [],
                );
              }
              listCarts[statuses[index].id]?.next(res.data.value, res.data.key);

              emit(
                CartsLoaded(
                  listCarts: listCarts,
                  statuses: statuses,
                ),
              );
            } else {
              emit(CartsFailure(message: res.message));
            }
          });
        } else {
          emit(
            CartsFailure(
              message: AppMessage(
                type: AppMessageType.failure,
                title: txtFailureTitle,
                content: 'Danh sách trạng thái rỗng. Hãy thử lại',
              ),
            ),
          );
        }
      } else {
        emit(CartsFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  void setReview(String id, int rate) {
    if (this.state is! CartsLoaded) {
      return;
    }

    var state = this.state as CartsLoaded;
    var map = state.listCarts;

    for (var key in map.keys) {
      var index = map[key]?.list.indexWhere((e) => e.id == id) ?? -1;
      if (index != -1) {
        CartModel item = map[key]!.list[index].copyWith(rate: rate);
        map[key]?.list[index] = item;
        emit(state.copyWith(listCarts: state.listCarts));
        return;
      }
    }
  }

  Future<AppMessage?> loadMore(String id) async {
    if (this.state is! CartsLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }
    var state = this.state as CartsLoaded;

    if (state.listCarts[id]?.hasNext() ?? false) {
      var res = await _repository.getsByStatusId(
        statusId: id,
        page: state.listCarts[id]!.page,
        limit: state.listCarts[id]!.limit,
      );
      if (res.type == ResponseModelType.success) {
        state.listCarts[id]!.next(res.data.value, res.data.key);

        emit(state.copyWith(listCarts: state.listCarts));
        return null;
      } else {
        return res.message;
      }
    }
    return null;
  }

  bool hasNext(String id) {
    if (state is CartsLoaded) {
      var state = this.state as CartsLoaded;
      return state.listCarts[id]?.hasNext() ?? false;
    }
    return false;
  }

  Future<AppMessage?> cancelOrder(String id) async {
    var res = await _repository.cancelOrder(id: id);
    if (res.type == ResponseModelType.success) {
      reload();
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> tap(String id) async {
    if (this.state is! CartsLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }
    var state = this.state as CartsLoaded;
    var listCart = state.listCarts[id];
    if ((listCart?.list.isEmpty ?? false) && (listCart?.hasNext() ?? false)) {
      return loadMore(id);
    }
    return null;
  }
}
