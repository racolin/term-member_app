enum HomeBodyType {
  home, order, store, promotion, other
}

enum DeliveryType {
  none, takeOut, delivery
}


class HomeState {

  final HomeBodyType homeBodyType;
  final DeliveryType deliveryType;
  final bool isExpandFloating;
  final bool isShowFloatButton;


  HomeState({
    required this.homeBodyType,
    this.deliveryType = DeliveryType.none,
    this.isExpandFloating = false,
    this.isShowFloatButton = false,
  });

  HomeState copyWith({
    HomeBodyType? homeBodyType,
    DeliveryType? deliveryType,
    bool? isExpandFloating,
    bool? isShowFloatButton,
  }) {
    return HomeState(
      homeBodyType: homeBodyType ?? this.homeBodyType,
      deliveryType: deliveryType ?? this.deliveryType,
      isExpandFloating: isExpandFloating ?? this.isExpandFloating,
      isShowFloatButton: isShowFloatButton ?? this.isShowFloatButton,
    );
  }
}
