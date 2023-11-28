import 'package:documentation/constants/strings.dart';
import 'package:documentation/controllers/common/select_list_controller.dart';
import 'package:documentation/controllers/schema/schema_controller.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:documentation/repositories/category_http_repository.dart';
import 'package:documentation/repositories/schema_http_repository.dart';
import 'package:get/get.dart';

class SchemaScreenBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final categoryHttpRepository = CategoryHttpRepository();

    Get.lazyPut(() => categoryHttpRepository);
    Get.lazyPut(() => SchemaHttpRepository());
    Get.lazyPut(() => SchemaCurrentItemController());

    await Get.putAsync(
      () => SelectListController<String>().init(() async {
        final set = await categoryHttpRepository.fetchCategories();
        return set.map((e) => e.title).toSet();
      }),
      tag: kCategoriesTag,
      permanent: true,
    );
    await Get.putAsync(() => SchemaController().init(), permanent: true);
  }
}
