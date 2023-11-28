// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schema _$SchemaFromJson(Map<String, dynamic> json) => Schema(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => SchemaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchemaToJson(Schema instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'items': instance.items,
    };
