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
  final HomeBodyType homeBodyType;
  final bool login;

  HomeLoaded({
    required this.homeBodyType,
    this.login = false,
  });

  HomeLoaded copyWith({
    HomeBodyType? homeBodyType,
    bool? login,
  }) {
    return HomeLoaded(
      homeBodyType: homeBodyType ?? this.homeBodyType,
      login: login ?? this.login,
    );
  }
}
