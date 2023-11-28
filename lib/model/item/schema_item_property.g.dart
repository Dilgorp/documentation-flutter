// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_item_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemaItemProperty _$SchemaItemPropertyFromJson(Map<String, dynamic> json) =>
    SchemaItemProperty(
      id: json['id'] as int,
      itemId: json['itemId'] as int,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      value: json['value'] as String,
    );

Map<String, dynamic> _$SchemaItemPropertyToJson(SchemaItemProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'property': instance.property,
      'value': instance.value,
    };
