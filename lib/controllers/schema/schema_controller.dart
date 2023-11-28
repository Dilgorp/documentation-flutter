import 'package:documentation/constants/strings.dart';
import 'package:documentation/controllers/common/select_list_controller.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:documentation/model/schema/schema.dart';
import 'package:documentation/model/schema/schema_item.dart';
import 'package:documentation/repositories/schema_http_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class SchemaController extends GetxController
    with StateMixin<SchemaScreenState> {
  final SchemaCurrentItemController _currentItemController =
      Get.find<SchemaCurrentItemController>();

  final SelectListController<String> _currentCategoryController =
      Get.find<SelectListController<String>>(tag: kCategoriesTag);

  final SchemaHttpRepository _repository = Get.find<SchemaHttpRepository>();

  Future<SchemaController> init() async {
    _currentItemController.schemaItem.listen((item) {
      _changeSchemaItem(item);
    });

    _currentCategoryController.selectedItem.listen((category) {
      if (category == null) return;

      _changeCategory(category);
    });

    _currentCategoryController.items.listen((categoriesSet) {
      if (categoriesSet.isEmpty) return;

      _changeCategoryItems(categoriesSet);
    });

    final schema = await _repository.fetchSchema();
    initState(schema);

    return this;
  }

  void _changeCategory(String value) {
    change(state!.copy(category: value), status: RxStatus.success());
  }

  void _changeSchemaItem(SchemaItem? value) {
    change(state!.copy(schemaItem: value, forceNull: true),
        status: RxStatus.success());
  }

  void _changeCategoryItems(Set<String> categories) {
    change(state!.copy(categoriesSet: categories), status: RxStatus.success());
  }

  void initState(Schema schema) {
    change(
      SchemaScreenState(
        schema: schema,
        categoriesSet: const {},
        category: _currentCategoryController.selectedItem.value ?? '',
      ),
      status: RxStatus.success(),
    );
  }
}

class SchemaScreenState extends Equatable {
  final Schema schema;
  final Set<String> categoriesSet;
  final String category;
  final SchemaItem? schemaItem;

  const SchemaScreenState({
    required this.schema,
    required this.categoriesSet,
    required this.category,
    this.schemaItem,
  });

  @override
  List<Object?> get props => [schema, categoriesSet, category, schemaItem];

  SchemaScreenState copy({
    Schema? schema,
    Set<String>? categoriesSet,
    String? category,
    SchemaItem? schemaItem,
    bool forceNull = false,
  }) {
    return SchemaScreenState(
      schema: schema ?? this.schema,
      categoriesSet: categoriesSet ?? this.categoriesSet,
      category: category ?? this.category,
      schemaItem: forceNull ? schemaItem : (schemaItem ?? this.schemaItem),
    );
  }
}
