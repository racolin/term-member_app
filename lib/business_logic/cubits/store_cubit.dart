import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/store_detail_model.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../repositories/store_repository.dart';
import '../states/store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository _repository;

  /// Nếu offline thì cần phải xử lý logic chỗ selectedId
  StoreCubit({required StoreRepository repository})
      : _repository = repository,
        super(StoreInitial()) {
    emit(StoreLoading());
    try {
      _repository.gets().then((list) {
        emit(StoreLoaded(list: list));
      });
    } on AppException catch (ex) {
      emit(StoreFailure(message: ex.message));
    }
  }

  // Action data
  Future<AppMessage?> reloadStores() async {
    try {
      var list = await _repository.gets();
      emit(StoreLoaded(list: list));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<StoreDetailModel?> getDetailStore(String id) async {
    try {
      return await _repository.getDetail(id: id);
    } on AppException catch (ex) {
      return null;
    }
    return null;
  }

  // Action UI
  AppMessage? selectStore(String id) {
    if (state is StoreLoaded) {
      if ((state as StoreLoaded).list.any((e) => e.id == id)) {
        emit((state as StoreLoaded).copyWith(selectedId: id));
        return null;
      }
    }
    return AppMessage(
      messageType: AppMessageType.failure,
      title: 'Có lỗi',
      content: 'Thao tác của bạn không được thực hiện',
    );
  }
}
