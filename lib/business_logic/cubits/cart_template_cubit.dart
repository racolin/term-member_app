import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_exception.dart';
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
      if (res.type == AppMessageType.success) {
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

    if (res.type == AppMessageType.success) {
      emit(CartTemplateLoaded(
        list: res.data.value,
        limit: res.data.key,
      ));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> editTemplate(
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

    var res = await _repository.edit(
      id: id,
      name: name,
      products: products,
    );

    if (res.type == AppMessageType.success) {
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

    if (res.type == AppMessageType.success) {
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

    if (res.type == AppMessageType.success) {
      var list = state.list;
      list.add(
        CartTemplateModel(
          id: res.data,
          name: name,
          index: list.length,
          products: products,
        ),
      );
      emit(CartTemplateLoaded(list: list));
      return null;
    } else {
      return res.message;
    }
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
    if (res.type == AppMessageType.success) {
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
      emit(CartTemplateLoaded(list: list));

      return null;
    } else {
      return res.message;
    }
  }
}
