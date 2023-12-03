import 'package:documentation/constants/strings.dart';
import 'package:documentation/controllers/common/selected_items_list_controller.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:documentation/model/category/category.dart';
import 'package:documentation/model/schema/schema.dart';
import 'package:documentation/model/schema/schema_item.dart';
import 'package:documentation/repositories/schema_http_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class SchemaTableScreenController extends GetxController
    with StateMixin<SchemaTableScreenState> {
  final SchemaCurrentItemController _currentItemController =
      Get.find<SchemaCurrentItemController>();

  final SelectedItemsListController<Category> _categoriesController =
      Get.find<SelectedItemsListController<Category>>();

  final SchemaHttpRepository _repository = Get.find<SchemaHttpRepository>();

  Future<SchemaTableScreenController> init() async {
    _currentItemController.schemaItem.listen((item) {
      _changeSelectedItem(item);
    });

    _categoriesController.selectedItems.listen((categories) {
      _changeSelectedCategories(categories);
    });

    _categoriesController.items.listen((categoriesSet) {
      _changeCategoryItems(categoriesSet);
    });

    final schema = await _repository.fetchSchema();
    initState(schema);

    return this;
  }

  void _changeSelectedCategories(List<Category> categories) {
    change(
      state!.copy(selectedCategories: categories),
      status: RxStatus.success(),
    );
  }

  void _changeSelectedItem(SchemaItem? value) {
    change(
      state!.copy(selectedItem: value, forceNull: true),
      status: RxStatus.success(),
    );
  }

  void _changeCategoryItems(List<Category> categories) {
    change(
      state!.copy(categoriesSet: categories),
      status: RxStatus.success(),
    );
  }

  void initState(Schema schema) {
    change(
      SchemaTableScreenState(
        schema: schema,
        categoriesSet: _categoriesController.items.value,
        selectedCategories: const [],
      ),
      status: RxStatus.success(),
    );
  }
}

class SchemaTableScreenState extends Equatable {
  final Schema schema;
  final List<Category> categoriesSet;
  final List<Category> selectedCategories;
  final SchemaItem? selectedItem;

  Map<Category, List<String>> get categoryValues {
    final Map<Category, List<String>> categoryValues = {};

    for (var category in selectedCategories) {
      final values = schema.items
          .mapMany((e) => e.item.categories)
          .where((element) => element.category == category)
          .map((e) => e.value)
          .toSet()
          .toList();

      values.add(kMissing);

      categoryValues[category] = values;
    }
    return categoryValues;
  }

  const SchemaTableScreenState({
    required this.schema,
    required this.categoriesSet,
    required this.selectedCategories,
    this.selectedItem,
  });

  @override
  List<Object?> get props => [
        schema,
        categoriesSet,
        selectedCategories,
        selectedItem,
      ];

  SchemaTableScreenState copy({
    Schema? schema,
    List<Category>? categoriesSet,
    List<Category>? selectedCategories,
    SchemaItem? selectedItem,
    bool forceNull = false,
  }) {
    return SchemaTableScreenState(
      schema: schema ?? this.schema,
      categoriesSet: categoriesSet ?? this.categoriesSet,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedItem:
          forceNull ? selectedItem : (selectedItem ?? this.selectedItem),
    );
  }
}
