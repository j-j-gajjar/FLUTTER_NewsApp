import 'package:flutter/material.dart';

class DropDownList extends StatelessWidget {
  final String name;
  final Function call;

  const DropDownList({Key? key, required this.name, required this.call})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(title: Text(name)),
      onTap: () => call(),
    );
  }
}
