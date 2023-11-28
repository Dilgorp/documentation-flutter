// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_item_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemaItemCategory _$SchemaItemCategoryFromJson(Map<String, dynamic> json) =>
    SchemaItemCategory(
      id: json['id'] as int,
      itemId: json['itemId'] as int,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      parentCategory: json['parentCategory'] == null
          ? null
          : Category.fromJson(json['parentCategory'] as Map<String, dynamic>),
      value: json['value'] as String,
    );

Map<String, dynamic> _$SchemaItemCategoryToJson(SchemaItemCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'category': instance.category,
      'parentCategory': instance.parentCategory,
      'value': instance.value,
    };
