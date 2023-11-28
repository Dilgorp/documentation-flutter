import 'package:documentation/model/item/item.dart';
import 'package:documentation/model/schema/schema_item.dart';
import 'package:get/get.dart';

class SchemaCurrentItemController extends GetxController
    with StateMixin<SchemaItem?> {
  final Rx<SchemaItem?> schemaItem = Rx(null);

  void changeSchemaItem(SchemaItem? item) {
    schemaItem.value = item;
    change(schemaItem.value, status: RxStatus.success());
  }
}
