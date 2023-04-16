import '../../presentation/res/strings/values.dart';

enum HomeBodyType {
  home(txtHome),
  order(txtOrder),
  store(txtStore),
  promotion(txtPromotion),
  other(txtOther);

  final String label;

  const HomeBodyType(this.label);
}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeBodyType type;
  final bool login;

  HomeLoaded({
    required this.type,
    this.login = false,
  });

  HomeLoaded copyWith({
    HomeBodyType? type,
    bool? login,
  }) {
    return HomeLoaded(
      type: type ?? this.type,
      login: login ?? this.login,
    );
  }
}
