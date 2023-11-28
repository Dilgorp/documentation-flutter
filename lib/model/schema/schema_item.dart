import 'package:documentation/model/item/item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schema_item.g.dart';

@JsonSerializable()
class SchemaItem extends Equatable {
  final int id;
  final int schemaId;
  final Item item;

  const SchemaItem({
    required this.id,
    required this.schemaId,
    required this.item,
  });

  @override
  List<Object?> get props => [id, schemaId, item];

  factory SchemaItem.fromJson(Map<String, dynamic> json) =>
      _$SchemaItemFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaItemToJson(this);
}
