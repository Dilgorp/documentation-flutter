import 'package:equatable/equatable.dart';

class SchemaItemCategory extends Equatable {
  final String title;
  final String name;

  const SchemaItemCategory({
    required this.title,
    required this.name,
  });

  @override
  List<Object?> get props => [title, name];

  int compareTo(SchemaItemCategory other) {
    return name.compareTo(other.name);
  }
}

int schemaCategoryItemComparator(SchemaItemCategory? a, SchemaItemCategory? b) {
  if (a == null && b == null) return 0;
  if (a == null && b != null) return 1;
  if (a != null && b == null) return -1;

  return a!.compareTo(b!);
}
