abstract class ProductScrollState {}

class ProductScrollInitial extends ProductScrollState {}

class ProductScrollLoaded extends ProductScrollState {
  final int index;

  ProductScrollLoaded({
    required this.index,
  });
}