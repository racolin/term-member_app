import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_exception.dart';
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

    try {
      _repository.getDetailById(id: id).then((detail) {
        emit(CartDetailLoaded(cart: detail));
      });
    } on AppException catch (ex) {}
  }

  Future<AppMessage?> review(int rate, String review) async {
    bool? result = await _repository.review(rate: rate, review: review);

    if (result == null || !result) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Có lỗi!',
        content: 'Có lỗi xảy ra khi đánh giá đơn hàng. Bạn có thể đánh giá lại!',
      );
    }
    return null;
  }
}
