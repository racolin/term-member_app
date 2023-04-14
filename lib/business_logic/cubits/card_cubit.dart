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
        super(CardInitial());

  // Action data

  Future<AppMessage?> loadCard() async {
    emit(CardLoading());

    try {
      var card = await _repository.getCard();

      if (card == null) {
        emit(CardEmpty());
      } else {
        emit(CardLoaded(card: card));
      }

    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }
}
