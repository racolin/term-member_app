import 'package:member_app/data/models/card_model.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final CardModel card;

  CardLoaded({
    required this.card,
  });
}

class CardWithoutData extends CardState {
  CardWithoutData();
}
