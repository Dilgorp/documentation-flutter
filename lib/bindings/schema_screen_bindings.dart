import 'package:documentation/constants/strings.dart';
import 'package:documentation/controllers/common/select_list_controller.dart';
import 'package:documentation/controllers/schema/schema_controller.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:get/get.dart';

class SchemaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SchemaCurrentItemController());
    Get.lazyPut(() => SelectListController<String>(), tag: kCategoriesTag);
    Get.lazyPut(() => SchemaController());
  }
}
