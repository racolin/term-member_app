import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_exception.dart';
import 'package:member_app/data/models/response_model.dart';
import '../../exception/app_message.dart';
import '../repositories/cart_repository.dart';
import '../states/cart_detail_state.dart';

class CartDetailCubit extends Cubit<CartDetailState> {
  final CartRepository _repository;

  CartDetailCubit({
    required CartRepository repository,
    required String id,
  })  : _repository = repository,
        super(CartDetailInitial()) {
    emit(CartDetailLoading());

    _repository.getDetailById(id: id).then((res) {
      if (res.type == ResponseModelType.success) {
        emit(CartDetailLoaded(cart: res.data));
      } else {
        emit(CartDetailFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> review(
    String id,
    int rate,
    String review,
  ) async {
    var res = await _repository.review(
      id: id,
      rate: rate,
      review: review,
    );

    if (res.type == ResponseModelType.success) {
      return null;
    } else {
      return res.message;
    }
  }
}
