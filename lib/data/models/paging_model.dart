class PagingModel<T> {
  final int limit;
  int page;
  int maxCount;
  List<T> list;

  PagingModel({
    required this.limit,
    this.page = 1,
    List<T>? list,
    this.maxCount = 1,
  }) : list = list ?? [];

  void next(List<T> appends, int maxCount) {
    this.maxCount = maxCount;
    page++;
    list.addAll(appends);
  }

  bool hasNext() {
    return list.length < maxCount;
  }

  PagingModel<T> copyWith({
    int? limit,
    int? page,
    int? maxCount,
    List<T>? list,
  }) {
    return PagingModel(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      maxCount: maxCount ?? this.maxCount,
      list: list ?? this.list,
    );
  }
}