import 'package:documentation/model/schema_item.dart';
import 'package:documentation/model/schema_item_category.dart';

extension SchemaItemListExtensions on List<SchemaItem> {
  Set<String> get categoriesSet {
    Set<String> set = {};

    for (SchemaItem item in this) {
      for (SchemaItemCategory category in item.categories) {
        set.add(category.title);
      }
    }

    return set;
  }
}
