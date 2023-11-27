import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class SelectListController<T> extends GetxController
    with StateMixin<SelectListControllerState<T>> {

  final Rx<T?> selectedItem = Rx(null);

  @override
  void onInit() {
    change(SelectListControllerState<T>(items: const {}, selectedItem: null),
        status: RxStatus.success());
    super.onInit();
  }

  void selectItem(T? value) {
    selectedItem.value = value;
    change(state!.copy(selectedItem: value), status: RxStatus.success());
  }

  void changeItems(Set<T> items) {
    change(state!.copy(items: items), status: RxStatus.success());
  }
}

class SelectListControllerState<T> extends Equatable {
  final Set<T> items;
  final T? selectedItem;

  const SelectListControllerState(
      {required this.items, required this.selectedItem});

  @override
  List<Object?> get props => [items, selectedItem];

  SelectListControllerState<T> copy({Set<T>? items, T? selectedItem}) =>
      SelectListControllerState<T>(
        items: items ?? this.items,
        selectedItem: selectedItem ?? this.selectedItem,
      );
}
