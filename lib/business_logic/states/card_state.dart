import '../../data/models/card_model.dart';
import '../../exception/app_message.dart';

abstract class CardState {}

class CardInitial extends CardState {
  CardInitial() {
    print(runtimeType);
  }
}

class CardLoading extends CardState {
  CardLoading() {
    print(runtimeType);
  }
}

class CardLoaded extends CardState {
  final CardModel card;

  CardLoaded({
    required this.card,
  }) {
    print(runtimeType);
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
    print(runtimeType);
  }
}