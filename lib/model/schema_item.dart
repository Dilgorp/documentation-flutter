import 'package:documentation/model/schema_item_category.dart';
import 'package:documentation/model/schema_item_property.dart';
import 'package:equatable/equatable.dart';

class SchemaItem extends Equatable {
  final String title;
  final String? description;
  final List<SchemaItemCategory> _categories = [];
  final List<SchemaItemProperty> _properties = [];

  SchemaItem({
    required this.title,
    required this.description,
    required List<SchemaItemCategory> categories,
    required List<SchemaItemProperty> properties,
  }) {
    _categories.addAll(categories);
    _properties.addAll(properties);
  }

  List<SchemaItemCategory> get categories {
    List<SchemaItemCategory> categories = [];
    categories.addAll(_categories);
    return categories;
  }

  List<SchemaItemProperty> get properties {
    List<SchemaItemProperty> properties = [];
    properties.addAll(_properties);
    return properties;
  }

  @override
  List<Object?> get props => [title, description, _categories, properties];
}
