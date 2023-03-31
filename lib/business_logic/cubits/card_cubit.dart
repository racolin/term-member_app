import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/card_state.dart';
import 'package:member_app/data/models/card_model.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CartInitial());

  void loadCard() {
    emit(CartLoading());
    emit(
      CartLoaded(
        cart: CardModel.fromMap({
          "id": "097595726",
          "name": "Phan Trung Tín",
          "scores": 500,
          "rankName": "Gold",
          "nextRankName": "Diamond",
          "nextRank": 4,
        }),
      ),
    );
  }
}
