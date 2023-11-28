import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable()
class Property extends Equatable {
  final int id;
  final String title;

  const Property({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
