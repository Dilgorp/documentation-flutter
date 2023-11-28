import 'package:equatable/equatable.dart';

class ItemCategory extends Equatable {
  final String title;
  final String value;

  const ItemCategory({required this.title, required this.value});

  @override
  List<Object?> get props => [title, value];

  int compareTo(ItemCategory other) {
    return value.compareTo(other.value);
  }
}

int itemCategoryComparator(ItemCategory? a, ItemCategory? b) {
  if (a == null && b == null) return 0;
  if (a == null && b != null) return 1;
  if (a != null && b == null) return -1;

  return a!.compareTo(b!);
}
