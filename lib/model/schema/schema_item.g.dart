// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemaItem _$SchemaItemFromJson(Map<String, dynamic> json) => SchemaItem(
      id: json['id'] as int,
      schemaId: json['schemaId'] as int,
      item: Item.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchemaItemToJson(SchemaItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schemaId': instance.schemaId,
      'item': instance.item,
    };
