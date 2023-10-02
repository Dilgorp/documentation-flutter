import 'package:flutter/material.dart';

class PanelDropdownMenu extends StatelessWidget {
  final Set<String> items;
  final Function(String? value) onSelected;
  final String initialItem;

  const PanelDropdownMenu({
    super.key,
    required this.items,
    required this.onSelected,
    required this.initialItem,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      enableSearch: false,
      inputDecorationTheme: const InputDecorationTheme(
        outlineBorder: BorderSide.none,
        border: InputBorder.none,
      ),
      initialSelection: initialItem,
      onSelected: (String? value) {
        onSelected(value);
      },
      dropdownMenuEntries:
          items.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
