import 'package:flutter/material.dart';

import '../../model/category_model.dart';

class DropDownList extends StatelessWidget {
  const DropDownList({super.key, required this.item, required this.onItemSelected});

  final SelectableItem item;
  final ValueChanged<SelectableItem> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(title: Text(item.name)),
      onTap: () => onItemSelected(item),
    );
  }
}
