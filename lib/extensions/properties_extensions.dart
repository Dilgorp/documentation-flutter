import 'package:documentation/constants/strings.dart';
import 'package:documentation/model/schema_item_property.dart';

extension PropertiesListExtensions on List<SchemaItemProperty> {
  String get returns =>
      firstWhere((element) => element.title == kReturns).value;
}
