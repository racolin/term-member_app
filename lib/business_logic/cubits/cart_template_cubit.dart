import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/cart_detail_model.dart';

import 'package:member_app/data/models/response_model.dart';
import '../../business_logic/repositories/cart_template_repository.dart';
import '../../business_logic/states/cart_template_state.dart';
import '../../data/models/cart_template_model.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';

class CartTemplateCubit extends Cubit<CartTemplateState> {
  final CartTemplateRepository _repository;

  CartTemplateCubit({
    required CartTemplateRepository repository,
  })  : _repository = repository,
        super(CartTemplateInitial()) {
    emit(CartTemplateLoading());

    _repository.gets().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(CartTemplateLoaded(
          list: res.data.value,
          limit: res.data.key,
        ));
      } else {
        emit(CartTemplateFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> reloadCartTemplates() async {
    var res = await _repository.gets();

    if (res.type == ResponseModelType.success) {
      emit(CartTemplateLoaded(
        list: res.data.value,
        limit: res.data.key,
      ));
      return null;
    } else {
      return res.message;
    }
  }

  AppMessage? add(CartTemplateModel model) {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }
    var state = this.state as CartTemplateLoaded;

    var list = state.list;
    list.add(model);

    emit(state.copyWith(list: list));

    return null;
  }

  AppMessage? addItemSelected(CartTemplateProductModel model) {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartTemplateLoaded;

    var selected = state.selected;

    if (selected == null) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: 'Bạn chưa chọn đơn hàng mẫu để thêm sản phẩm.',
      );
    } else {
      selected = selected.copyWith(products: selected.products + [model]);
    }

    emit(state.copyWith(selected: selected));

    return null;
  }

  Future<AppMessage?> updateTemplate(
    String id,
    String name,
    List<CartTemplateProductModel> products,
  ) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartTemplateLoaded;

    var res = await _repository.update(
      id: id,
      name: name,
      products: products,
    );

    if (res.type == ResponseModelType.success) {
      var list = state.list;
      int index = list.indexWhere((e) => e.id == id);
      if (index == -1) {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Không tìm thấy mã của template muốn chỉnh sửa.',
        );
      }
      list[index] = list[index].copyWith(
        products: products,
        name: name,
      );
      emit(state.copyWith(list: list));

      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> deleteCart(String id) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartTemplateLoaded;

    var res = await _repository.delete(id: id);

    if (res.type == ResponseModelType.success) {
      var list = state.list;
      int index = list.indexWhere((e) => e.id == id);
      if (index == -1) {
        return AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Không tìm thấy mã của đơn hàng mẫu muốn xoá.',
        );
      }

      list.removeAt(index);

      emit(state.copyWith(
        list: list,
      ));
      return null;
    } else {
      return res.message;
    }
  }

  AppMessage? deleteItemInCart(String id, String pId) {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartTemplateLoaded;

    if (state.selected?.id == id) {
      state.selected?.products.removeWhere((e) => e.id == pId);
      emit(state);
      return null;
    }

    return AppMessage(
      type: AppMessageType.failure,
      title: txtFailureTitle,
      content: 'Không tìm thấy sản phẩm và đơn mẫu!',
    );
  }

  Future<AppMessage?> createCart(
    String name,
    List<CartTemplateProductModel> products,
  ) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartTemplateLoaded;

    var res = await _repository.create(
      name: name,
      products: products,
    );

    if (res.type == ResponseModelType.success) {
      var list = state.list;
      list.add(
        CartTemplateModel(
          id: res.data,
          name: name,
          index: list.length,
          products: products,
        ),
      );
      emit(state.copyWith(list: list));
      return null;
    } else {
      return res.message;
    }
  }

  int get length {
    return list.length;
  }

  List<CartTemplateModel> get list {
    if (state is! CartTemplateLoaded) {
      return [];
    }
    return (state as CartTemplateLoaded).list;
  }

  Future<AppMessage?> arrangeCart(List<String> ids) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartTemplateLoaded;

    var res = await _repository.arrange(ids: ids);
    if (res.type == ResponseModelType.success) {
      var list = <CartTemplateModel>[];
      for (int i = 0; i < ids.length; i++) {
        int index = state.list.indexWhere((e) => ids[i] == e.id);
        if (index == -1) {
          return AppMessage(
            type: AppMessageType.failure,
            title: 'Lỗi',
            content:
                'Dữ liệu trên giao diện không đúng. Hãy thoát ra và vào lại!',
          );
        }
        list.add(state.list[index].copyWith(index: i));
      }
      emit(state.copyWith(list: list));

      return null;
    } else {
      return res.message;
    }
  }

  Future<ResponseModel<String>> createTemplateFromCart(
    String name,
    List<CartProductModel> items,
  ) async {
    if (this.state is! CartTemplateLoaded) {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.notify,
          title: txtNotifyTitle,
          content: 'Dữ liệu chưa được tại. Hãy thử lại!',
        ),
      );
    }
    var state = this.state as CartTemplateLoaded;
    if (state.canCreate) {
      var res = await _repository.create(
          name: name,
          products: items
              .map((e) => CartTemplateProductModel(
                    options: e.options,
                    amount: e.amount,
                    id: e.id,
                  ))
              .toList());
      return res;
    } else {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: txtFailureTitle,
          content: 'Số lượng đơn mẫu của bạn đã đạt giới hạn.',
        ),
      );
    }
  }

  AppMessage? select(String id) {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartTemplateLoaded;

    int index = state.list.indexWhere((e) => id == e.id);

    if (index == -1) {
      return AppMessage(
        type: AppMessageType.error,
        title: txtFailureTitle,
        content: 'Lỗi xảy ra khi đơn hàng mẫu không tồn tại. Hãy thử lại!',
      );
    }

    emit(
      state.copyWith(
        selected: CartTemplateModel.fromMap(
          state.list[index].toMap(),
        ),
      ),
    );

    return null;
  }
}
