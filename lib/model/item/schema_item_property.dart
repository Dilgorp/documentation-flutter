import 'package:documentation/model/property.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schema_item_property.g.dart';

@JsonSerializable()
class SchemaItemProperty extends Equatable {
  final int id;
  final int itemId;
  final Property property;
  final String value;

  const SchemaItemProperty({
    required this.id,
    required this.itemId,
    required this.property,
    required this.value,
  });

  @override
  List<Object?> get props => [id, itemId, property, value];

  factory SchemaItemProperty.fromJson(Map<String, dynamic> json) =>
      _$SchemaItemPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaItemPropertyToJson(this);
}
