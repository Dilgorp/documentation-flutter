import 'package:documentation/model/category/category.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schema_item_category.g.dart';

@JsonSerializable()
class SchemaItemCategory extends Equatable {
  final int id;
  final int itemId;
  final Category category;
  final Category? parentCategory;
  final String value;

  const SchemaItemCategory({
    required this.id,
    required this.itemId,
    required this.category,
    required this.parentCategory,
    required this.value,
  });

  @override
  List<Object?> get props => [id, itemId, category, parentCategory, value];

  int compareTo(SchemaItemCategory other) {
    return value.compareTo(other.value);
  }

  factory SchemaItemCategory.fromJson(Map<String, dynamic> json) =>
      _$SchemaItemCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaItemCategoryToJson(this);
}

int schemaCategoryItemComparator(SchemaItemCategory? a, SchemaItemCategory? b) {
  if (a == null && b == null) return 0;
  if (a == null && b != null) return 1;
  if (a != null && b == null) return -1;

  return a!.compareTo(b!);
}
