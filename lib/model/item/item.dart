import 'package:documentation/model/item/schema_item_category.dart';
import 'package:documentation/model/item/schema_item_property.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  final int id;
  final String title;
  final String? description;
  final List<SchemaItemCategory> _categories = [];
  final List<SchemaItemProperty> _properties = [];

  Item({
    required this.id,
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
  List<Object?> get props => [id, title, description, _categories, properties];

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
