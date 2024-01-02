import '../../data/models/card_model.dart';
import '../../exception/app_message.dart';

abstract class CardState {}

class CardInitial extends CardState {
  CardInitial() {
    // printruntimeType);
  }
}

class CardLoading extends CardState {
  CardLoading() {
    // printruntimeType);
  }
}

class CardLoaded extends CardState {
  final CardModel card;

  CardLoaded({
    required this.card,
  }) {
    // printruntimeType);
  }

  CardLoaded copyWith({
    CardModel? card,
  }) {
    return CardLoaded(
      card: card ?? this.card,
    );
  }
}

class CardFailure extends CardState {
  final AppMessage message;
  CardFailure({required this.message}) {
    // printruntimeType);
  }
}