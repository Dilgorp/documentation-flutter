import 'package:documentation/constants/strings.dart';
import 'package:documentation/model/item/schema_item_property.dart';

extension PropertiesListExtensions on List<SchemaItemProperty> {
  String get returns =>
      firstWhere((element) => element.property.title == kReturns).value;
}
