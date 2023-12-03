import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class SelectedItemsListController<T> extends GetxController
    with StateMixin<SelectedItemsListControllerState<T>> {
  final Rx<List<T>> selectedItems = Rx([]);
  final Rx<List<T>> items = Rx([]);

  Future<SelectedItemsListController<T>> init(
    Future<List<T>> Function() initItems,
  ) async {
    items.value = await initItems.call();

    change(
      SelectedItemsListControllerState<T>(
        items: items.value,
        selectedItems: const [],
      ),
      status: RxStatus.success(),
    );

    return this;
  }

  void selectItem(T item) {
    if (this.selectedItems.value.contains(item)) return;

    final List<T> selectedItems = [];
    selectedItems.addAll(this.selectedItems.value);
    selectedItems.add(item);
    this.selectedItems.value = selectedItems;

    change(state!.selectItem(item), status: RxStatus.success());
  }

  void removeItem(T item) {
    final List<T> selectedItems = [];
    selectedItems.addAll(
      this.selectedItems.value.where((element) => element != item),
    );

    this.selectedItems.value = selectedItems;

    change(state!.removeItem(item), status: RxStatus.success());
  }

  void changeItems(List<T> items) {
    change(state!.copy(items: items), status: RxStatus.success());
  }
}

class SelectedItemsListControllerState<T> extends Equatable {
  final List<T> items;
  final List<T> selectedItems;

  const SelectedItemsListControllerState({
    required this.items,
    required this.selectedItems,
  });

  @override
  List<Object?> get props => [items, selectedItems];

  SelectedItemsListControllerState<T> copy({
    List<T>? items,
    List<T>? selectedItems,
  }) =>
      SelectedItemsListControllerState<T>(
        items: items ?? this.items,
        selectedItems: selectedItems ?? this.selectedItems,
      );

  SelectedItemsListControllerState<T> selectItem(T item) {
    final List<T> items = [];
    items.addAll(this.items);

    final List<T> selectedItems = [];
    selectedItems.addAll(this.selectedItems);
    selectedItems.add(item);

    return SelectedItemsListControllerState(
      items: items,
      selectedItems: selectedItems,
    );
  }

  SelectedItemsListControllerState<T> removeItem(T item) {
    final List<T> items = [];
    items.addAll(this.items);

    final List<T> selectedItems = [];
    selectedItems.addAll(
      this.selectedItems.where((element) => element != item),
    );

    return SelectedItemsListControllerState(
      items: items,
      selectedItems: selectedItems,
    );
  }

  SelectedItemsListControllerState<T> clear() {
    final List<T> items = [];
    items.addAll(this.items);

    return SelectedItemsListControllerState(
      items: items,
      selectedItems: const [],
    );
  }
}
