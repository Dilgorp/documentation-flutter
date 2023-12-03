import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int id;
  final String title;

  const Category({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  Category copy() => Category(id: id, title: title);
}
