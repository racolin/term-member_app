import 'package:member_app/presentation/res/strings/values.dart';

enum HomeBodyType {
  home(txtHome),
  order(txtOrder),
  store(txtStore),
  promotion(txtPromotion),
  other(txtOther);

  final String label;

  const HomeBodyType(this.label);
}

enum DeliveryType {
  none(""),
  takeOut(txtTake),
  delivery(txtDelivery);

  final String label;
  final int icon = 0xe22e;

  const DeliveryType(this.label);
}

class HomeState {
  final HomeBodyType homeBodyType;
  final DeliveryType deliveryType;
  final String deliveryDescription;
  final bool isExpandFloating;
  final bool isShowFloatButton;

  HomeState({
    required this.homeBodyType,
    this.deliveryType = DeliveryType.none,
    this.deliveryDescription = "",
    this.isExpandFloating = false,
    this.isShowFloatButton = false,
  });

  HomeState copyWith({
    HomeBodyType? homeBodyType,
    DeliveryType? deliveryType,
    bool? isExpandFloating,
    bool? isShowFloatButton,
    String? deliveryDescription,
  }) {
    return HomeState(
      homeBodyType: homeBodyType ?? this.homeBodyType,
      deliveryType: deliveryType ?? this.deliveryType,
      deliveryDescription: deliveryDescription ?? this.deliveryDescription,
      isExpandFloating: isExpandFloating ?? this.isExpandFloating,
      isShowFloatButton: isShowFloatButton ?? this.isShowFloatButton,
    );
  }
}
