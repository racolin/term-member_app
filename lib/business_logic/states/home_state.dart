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

class HomeState {
  final HomeBodyType homeBodyType;
  final bool login;

  HomeState({
    required this.homeBodyType,
    this.login = false,
  });

  HomeState copyWith({
    HomeBodyType? homeBodyType,
    bool? login,
  }) {
    return HomeState(
      homeBodyType: homeBodyType ?? this.homeBodyType,
      login: login ?? this.login,
    );
  }
}
