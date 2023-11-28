import 'package:documentation/model/schema/schema_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schema.g.dart';

@JsonSerializable()
class Schema extends Equatable {
  final int id;
  final String title;
  final String? description;
  final List<SchemaItem> _items = [];

  Schema({
    required this.id,
    required this.title,
    this.description,
    required List<SchemaItem> items,
  }) {
    _items.addAll(items);
  }

  List<SchemaItem> get items {
    List<SchemaItem> items = [];
    items.addAll(_items);
    return items;
  }

  @override
  List<Object?> get props => [id, title, description, items];

  factory Schema.fromJson(Map<String, dynamic> json) => _$SchemaFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaToJson(this);
}
