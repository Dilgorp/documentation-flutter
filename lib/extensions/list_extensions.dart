extension ListExtensions<T> on List<T> {
  Map<E?, List<T>> groupBy<E>(E Function(T item) keySelector) {
    Map<E?, List<T>> map = {};

    for (T element in this) {
      E? key = keySelector(element);
      List<T> list = map[key] ?? [];
      list.add(element);
      map[key] = list;
    }

    return map;
  }
}
