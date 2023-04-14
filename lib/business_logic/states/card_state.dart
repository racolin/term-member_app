import '../../data/models/card_model.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final CardModel card;

  CardLoaded({
    required this.card,
  });

  CardLoaded copyWith({
    CardModel? card,
  }) {
    return CardLoaded(
      card: card ?? this.card,
    );
  }
}

class CardEmpty extends CardState {
  CardEmpty();
}
