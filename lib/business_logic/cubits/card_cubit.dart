import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/repositories/member_repository.dart';
import '../../exception/app_message.dart';
import '../states/card_state.dart';
import '../../exception/app_exception.dart';

class CardCubit extends Cubit<CardState> {
  final MemberRepository _repository;

  CardCubit({
    required MemberRepository repository,
  })  : _repository = repository,
        super(CardInitial()) {
    try {
      _repository.getCard().then((card) {
        if (card == null) {
          emit(
            CardFailure(
              message: AppMessage(
                type: AppMessageType.failure,
                title: 'Cảnh báo',
                content: 'Thẻ khách hàng trống',
              ),
            ),
          );
          return;
        }
        emit(CardLoaded(card: card));
      });
    } on AppException catch (ex) {
      emit(CardFailure(message: ex.message));
    }
  }

  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadCard() async {
    try {
      var card = await _repository.getCard();
      if (card == null) {
        emit(
          CardFailure(
            message: AppMessage(
              type: AppMessageType.failure,
              title: 'Cảnh báo',
              content: 'Thẻ khách hàng trống',
            ),
          ),
        );
      } else {
        emit(CardLoaded(card: card));
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }
}
