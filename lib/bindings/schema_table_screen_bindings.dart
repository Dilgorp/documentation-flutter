import 'package:documentation/controllers/common/selected_items_list_controller.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:documentation/controllers/schema/schema_table_controller.dart';
import 'package:documentation/model/category/category.dart';
import 'package:documentation/repositories/category_http_repository.dart';
import 'package:documentation/repositories/schema_http_repository.dart';
import 'package:get/get.dart';

class SchemaTableScreenBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final categoryHttpRepository = CategoryHttpRepository();

    Get.lazyPut(() => categoryHttpRepository);
    Get.lazyPut(() => SchemaHttpRepository());
    Get.lazyPut(() => SchemaCurrentItemController());

    await Get.putAsync(
      () => SelectedItemsListController<Category>().init(
        () async {
          final categories = <Category>[];
          final result = await categoryHttpRepository.fetchCategories();
          categories.addAll(result);
          return categories;
        },
      ),
      permanent: true,
    );

    await Get.putAsync(
      () => SchemaTableScreenController().init(),
      permanent: true,
    );
  }
}
