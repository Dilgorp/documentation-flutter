import 'package:documentation/constants/strings.dart';
import 'package:documentation/controllers/common/select_list_controller.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:documentation/data/mock_schema_item.dart';
import 'package:documentation/extensions/schema_item_list_extensions.dart';
import 'package:documentation/model/schema.dart';
import 'package:documentation/model/schema_item.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class SchemaController extends GetxController
    with StateMixin<SchemaScreenState> {
  final SchemaCurrentItemController _currentItemController =
      Get.find<SchemaCurrentItemController>();

  final SelectListController<String> _currentCategoryController =
      Get.find<SelectListController<String>>(tag: kCategoriesTag);

  @override
  void onInit() {
    _currentCategoryController.changeItems(kSchemaItems.categoriesSet);
    _currentCategoryController.selectItem(kController);
    _currentItemController.schemaItem.listen((item) {
      _changeSchemaItem(item);
    });

    _currentCategoryController.selectedItem.listen((category) {
      if (category == null) return;

      _changeCategory(category);
    });
    initState();
    super.onInit();
  }

  void _changeCategory(String value) {
    change(state!.copy(category: value), status: RxStatus.success());
  }

  void _changeSchemaItem(SchemaItem? value) {
    change(state!.copy(schemaItem: value, forceNull: true),
        status: RxStatus.success());
  }

  void initState() {
    change(
      SchemaScreenState(
        schema: Schema(
          title: 'Test schema',
          description: 'Test schema description',
          items: kSchemaItems,
        ),
        categoriesSet: kSchemaItems.categoriesSet,
        category: kController,
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
