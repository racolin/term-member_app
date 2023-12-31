import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/cart_detail_model.dart';

import 'package:member_app/data/models/response_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
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
    String? review,
    List<String> like,
    List<String> dislike,
  ) async {
    var res = await _repository.review(
      id: id,
      rate: rate,
      review: review,
      like: like,
      dislike: dislike,
    );

    if (res.type == ResponseModelType.success) {
      if (state is CartDetailLoaded) {
        emit(
          (state as CartDetailLoaded).copyWith(
            cart: (state as CartDetailLoaded).cart.copyWith(
                  review: CartReviewModel(
                    rate: rate,
                    review: review,
                    likeItems: like,
                    dislikeItems: dislike,
                  ),
                ),
          ),
        );
      }
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> createPayment() async {
    if (this.state is! CartDetailLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartDetailLoaded;

    var res = await _repository.createPayment(
        lang: 'vi',
        orderId: state.cart.id,
        redirectUrl: 'member_app_11052001://member_app.com');

    if (res.type == ResponseModelType.success) {
      final Uri launchUri = Uri.parse(res.data.payUrl);
      await launchUrl(launchUri);
      emit(state.copyWith(cart: state.cart.copyWith(isPaid: true)));
      return null;
    } else {
      return res.message;
    }
  }

  void setReviewShipper(CartReviewShipperModel model) {
    if (this.state is! CartDetailLoaded) {
      return;
    }
    var state = this.state as CartDetailLoaded;
    emit(
      state.copyWith(
        cart: state.cart.copyWith(
          reviewShipper: model,
        ),
      ),
    );
  }

  Future<AppMessage?> reviewShipper(
    String id,
    int rate,
    String? review,
  ) async {
    // var res = await _repository.reviewShipper(
    //   id: id,
    //   rate: rate,
    //   review: review,
    // );
    //
    // if (res.type == ResponseModelType.success) {
    //   return null;
    // } else {
    //   return res.message;
    // }
  }
}
