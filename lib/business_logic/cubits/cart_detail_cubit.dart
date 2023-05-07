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
        if (detail != null) {
          emit(CartDetailLoaded(cart: detail));
        } else {
          emit(
            CartDetailFailure(
              message: AppMessage(
                type: AppMessageType.failure,
                title: 'Không tìm thấy',
                content: 'Không tìm được chi tiết của đơn hàng',
              ),
            ),
          );
        }
      });
    } on AppException catch (ex) {}
  }

  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> review(int rate, String review) async {
    bool? result = await _repository.review(rate: rate, review: review);

    if (result == null || !result) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Có lỗi!',
        content:
            'Có lỗi xảy ra khi đánh giá đơn hàng. Bạn có thể đánh giá lại!',
      );
    }
    return null;
  }
}
