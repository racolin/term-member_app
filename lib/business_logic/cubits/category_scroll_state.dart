abstract class CategoryScrollState {}

class CategoryScrollInitial extends CategoryScrollState {}

class CategoryScrollIndex extends CategoryScrollState {
  final int index;

  CategoryScrollIndex({
    required this.index,
  });
}
