import 'package:equatable/equatable.dart';

class SchemaItemProperty extends Equatable {
  final String title;
  final String value;

  const SchemaItemProperty({
    required this.title,
    required this.value,
  });

  @override
  List<Object?> get props => [title, value];
}
