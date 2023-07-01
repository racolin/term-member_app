import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/blocs/interval/interval_submit.dart';
import 'package:member_app/data/models/store_detail_model.dart';
import 'package:member_app/data/models/store_model.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/store_repository.dart';
import '../states/store_state.dart';

class StoreCubit extends Cubit<StoreState>
    implements IntervalSubmit<StoreModel> {
  final StoreRepository _repository;

  /// Nếu offline thì cần phải xử lý logic chỗ selectedId
  StoreCubit({required StoreRepository repository})
      : _repository = repository,
        super(StoreInitial()) {
    emit(StoreLoading());
    _repository.gets().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(StoreLoaded(list: res.data));
      } else {
        emit(StoreFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadStores() async {
    var res = await _repository.gets();
    if (res.type == ResponseModelType.success) {
      emit(StoreLoaded(list: res.data));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> loadDetailStore(String id) async {
    if (state is! StoreLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var res = await _repository.getDetail(id: id);
    if (res.type == ResponseModelType.success) {
      emit((state as StoreLoaded).copyWith(detail: res.data));
      return null;
    } else {
      return res.message;
    }
  }

  Future<StoreDetailModel?> getDetailStore(String id) async {

    var res = await _repository.getDetail(id: id);
    if (res.type == ResponseModelType.success) {
      return res.data;
    } else {
      return null;
    }
  }

  StoreDetailModel? get detailStore {
    if (state is! StoreLoaded) {
      return null;
    }
    return (state as StoreLoaded).detail;
  }

  // Action UI
  // AppMessage? selectStore(String id) {
  //   if (state is! StoreLoaded) {
  //     return AppMessage(
  //       type: AppMessageType.failure,
  //       title: txtFailureTitle,
  //       content: txtToFast,
  //     );
  //   }
  //
  //   if ((state as StoreLoaded).list.any((e) => e.id == id)) {
  //     emit((state as StoreLoaded).copyWith(selectedId: id));
  //     return null;
  //   } else {}
  // }

  @override
  Future<List<StoreModel>> submit([String? key]) async {
    if (this.state is! StoreLoaded) {
      return [];
    }
    var state = this.state as StoreLoaded;
    if (key == null || key.isEmpty) {
      return state.list;
    }
    return state.list
        .where(
          (e) =>
              e.address.toUpperCase().contains(key.toUpperCase()) ||
              e.name.toUpperCase().contains(key.toUpperCase()),
        )
        .toList();
  }
}
