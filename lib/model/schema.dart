import 'package:documentation/model/schema_item.dart';
import 'package:equatable/equatable.dart';

class Schema extends Equatable {
  final String title;
  final String? description;
  final List<SchemaItem> _items = [];

  Schema({
    required this.title,
    this.description,
    required List<SchemaItem> items,
  }) {
    _items.addAll(items);
  }

  List<SchemaItem> get items {
    List<SchemaItem> items = [];
    items.addAll(_items);
    return items;
  }

  @override
  List<Object?> get props => [title, description, items];
}
