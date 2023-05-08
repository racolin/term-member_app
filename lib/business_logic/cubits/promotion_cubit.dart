import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_message.dart';
import 'package:member_app/data/models/response_model.dart';
import '../repositories/promotion_repository.dart';
import '../states/promotion_state.dart';

class PromotionCubit extends Cubit<PromotionState> {
  final PromotionRepository _repository;

  PromotionCubit({required PromotionRepository repository})
      : _repository = repository,
        super(PromotionInitial()) {
    emit(PromotionLoading());
    _repository.gets().then((res) {
      if (res.type == ResponseModelType.success) {
        var map = res.data;
        if (state is PromotionLoaded) {
          emit(
            (state as PromotionLoaded).copyWith(
              promotions: map.value,
              threshold: map.key,
            ),
          );
        } else {
          emit(PromotionLoaded(
            promotions: map.value,
            categories: const [],
            threshold: map.key,
          ));
        }
      } else {
        emit(PromotionFailure(message: res.message));
        return;
      }
    });
    _repository.getCategories().then((res) {
      if (res.type == ResponseModelType.success) {
        var list = res.data;
        if (state is PromotionLoaded) {
          emit((state as PromotionLoaded).copyWith(categories: list));
        } else {
          emit(PromotionLoaded(
            categories: list,
            promotions: const [],
            threshold: 0,
          ));
        }
      } else {
        emit(PromotionFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> reloadPromotions() async {
    var resStatus = await _repository.gets();
    if (resStatus.type == ResponseModelType.success) {
      var map = resStatus.data;
      if (state is PromotionLoaded) {
        emit(
          (state as PromotionLoaded).copyWith(
            promotions: map.value,
            threshold: map.key,
          ),
        );
      } else {
        emit(PromotionLoaded(
          promotions: map.value,
          categories: const [],
          threshold: map.key,
        ));
      }
    } else {
      return resStatus.message;
    }
    var resList = await _repository.getCategories();
    if (resList.type == ResponseModelType.success) {
      var list = resList.data;

      if (state is PromotionLoaded) {
        emit((state as PromotionLoaded).copyWith(categories: list));
      } else {
        emit(PromotionLoaded(
          categories: list,
          promotions: const [],
          threshold: 0,
        ));
      }
      return null;
    } else {
      return resList.message;
    }
  }
}
