import 'package:documentation/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class SchemaCategoriesController extends GetxController
    with StateMixin<SchemaCategoriesState> {
  final RxString category = kController.obs;

  @override
  void onInit() {
    change(const SchemaCategoriesState(categories: {}, category: ''),
        status: RxStatus.success());
    super.onInit();
  }

  void changeCategory(String value) {
    category.value = value;
    change(state!.copy(category: value), status: RxStatus.success());
  }

  void changeCategories(Set<String> categories) {
    change(state!.copy(categories: categories), status: RxStatus.success());
  }
}

class SchemaCategoriesState extends Equatable {
  final Set<String> categories;
  final String category;

  const SchemaCategoriesState({
    required this.categories,
    required this.category,
  });

  @override
  List<Object?> get props => [categories, category];

  SchemaCategoriesState copy({Set<String>? categories, String? category}) =>
      SchemaCategoriesState(
        categories: categories ?? this.categories,
        category: category ?? this.category,
      );
}
