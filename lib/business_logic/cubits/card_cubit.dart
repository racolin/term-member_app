import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/repositories/member_repository.dart';
import '../../exception/app_message.dart';
import '../states/card_state.dart';

class CardCubit extends Cubit<CardState> {
  final MemberRepository _repository;

  CardCubit({
    required MemberRepository repository,
  })  : _repository = repository,
        super(CardInitial()) {
    emit(CardLoading());
    _repository.getCard().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(CardLoaded(card: res.data));
      } else {
        emit(CardFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  Future<AppMessage?> reloadCard() async {
    var res = await _repository.getCard();
    if (res.type == ResponseModelType.success) {
      emit(CardLoaded(card: res.data));
      return null;
    } else {
      return res.message;
    }
  }

  // get data method: return model if state is loaded, else return null
}
