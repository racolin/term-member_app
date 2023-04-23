import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_exception.dart';
import '../../business_logic/repositories/cart_template_repository.dart';
import '../../business_logic/states/cart_template_state.dart';
import '../../data/models/cart_template_model.dart';
import '../../exception/app_message.dart';

class CartTemplateCubit extends Cubit<CartTemplateState> {
  final CartTemplateRepository _repository;

  CartTemplateCubit({
    required CartTemplateRepository repository,
  })  : _repository = repository,
        super(CartTemplateInitial()) {
    emit(CartTemplateLoading());

    try {
      _repository.gets().then((map) {
        emit(CartTemplateLoaded(
          list: map.value,
          limit: map.key,
        ));
      });
    } on AppException catch (ex) {
    }
  }

  Future<AppMessage?> reloadCartTemplates() async {
    if (state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Cảnh báo',
        content: 'Thao tác của bạn quá nhanh. Hãy thử lại!',
      );
    }

    try {
      var map = await _repository.gets();
      emit(CartTemplateLoaded(
        list: map.value,
        limit: map.key,
      ));
    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }

  Future<AppMessage?> editTemplate(
    String id,
    String name,
    List<CartTemplateProductModel> products,
  ) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Cảnh báo',
        content: 'Thao tác của bạn quá nhanh. Hãy thử lại!',
      );
    }

    var state = this.state as CartTemplateLoaded;

    try {
      bool? result = await _repository.edit(
        id: id,
        name: name,
        products: products,
      );

      if (result == null || !result) {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Template chưa được sửa. Hãy thử lại!',
        );
      }
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
    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }

  Future<AppMessage?> deleteCart(String id) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Cảnh báo',
        content: 'Thao tác của bạn quá nhanh. Hãy thử lại!',
      );
    }

    var state = this.state as CartTemplateLoaded;

    try {
      var result = await _repository.delete(id: id);

      if (result == null || !result) {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Template chưa được xoá. Hãy thử lại!',
        );
      }

      var list = state.list;
      int index = list.indexWhere((e) => e.id == id);
      if (index == -1) {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Không tìm thấy mã của template muốn xoá.',
        );
      }

      list.removeAt(index);

      emit(state.copyWith(
        list: list,
      ));
    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }

  Future<AppMessage?> createCart(
    String name,
    List<CartTemplateProductModel> products,
  ) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Cảnh báo',
        content: 'Thao tác của bạn quá nhanh. Hãy thử lại!',
      );
    }

    var state = this.state as CartTemplateLoaded;

    try {
      String? id = await _repository.create(
        name: name,
        products: products,
      );
      if (id == null) {
        return AppMessage(
          type: AppMessageType.failure,
          title: 'Lỗi',
          content: 'Cart Template này chưa được tạo. Hãy thử lại!',
        );
      }

      var list = state.list;
      list.add(
        CartTemplateModel(
          id: id,
          name: name,
          index: list.length,
          products: products,
        ),
      );
      emit(CartTemplateLoaded(list: list));
    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }

  Future<AppMessage?> arrangeCart(List<String> ids) async {
    if (this.state is! CartTemplateLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Cảnh báo',
        content: 'Thao tác của bạn quá nhanh. Hãy thử lại!',
      );
    }

    var state = this.state as CartTemplateLoaded;

    try {
      bool? result = await _repository.arrange(ids: ids);
      if (result == null || !result) {
        return AppMessage(
          type: AppMessageType.failure,
          title: 'Lỗi',
          content: 'Cart Templates chưa được sắp xếp. Hãy thử lại!',
        );
      }

      var list = <CartTemplateModel>[];
      for (int i = 0; i < ids.length; i++) {
        int index = state.list.indexWhere((e) => ids[i] == e.id);
        if (index == -1) {
          return AppMessage(
            type: AppMessageType.failure,
            title: 'Lỗi',
            content: 'Dữ liệu trên giao diện không đúng. Hãy thoát ra và vào lại!',
          );
        }
        list.add(state.list[index].copyWith(index: i));
      }
      emit(CartTemplateLoaded(list: list));
    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }
}
