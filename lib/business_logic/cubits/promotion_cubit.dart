import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_message.dart';
import '../../exception/app_exception.dart';
import '../repositories/promotion_repository.dart';
import '../states/promotion_state.dart';

class PromotionCubit extends Cubit<PromotionState> {
  final PromotionRepository _repository;

  PromotionCubit({required PromotionRepository repository})
      : _repository = repository,
        super(PromotionInitial()) {
    emit(PromotionLoading());
    try {
      _repository.gets().then((map) {
        if (state is PromotionLoaded) {
          emit((state as PromotionLoaded).copyWith(
            promotions: map.value, threshold: map.key,),);
        } else {
          emit(PromotionLoaded(
            promotions: map.value,
            categories: const [],
            threshold: map.key,
          ));
        }
      });
      _repository.getCategories().then((list) {
        if (state is PromotionLoaded) {
          emit((state as PromotionLoaded).copyWith(categories: list));
        } else {
          emit(PromotionLoaded(
            categories: list, promotions: const [],threshold: 0,
          ));
        }
      });
    } on AppException catch (ex) {}
  }

  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> reloadPromotions() async {
    try {
      var map = await _repository.gets();
      if (state is PromotionLoaded) {
        emit((state as PromotionLoaded).copyWith(
          promotions: map.value, threshold: map.key,),);
      } else {
        emit(PromotionLoaded(
          promotions: map.value,
          categories: const [],
          threshold: map.key,
        ));
      }
      _repository.getCategories().then((list) {
        if (state is PromotionLoaded) {
          emit((state as PromotionLoaded).copyWith(categories: list));
        } else {
          emit(PromotionLoaded(
            categories: list, promotions: const [],threshold: 0,
          ));
        }
      });
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }
}
