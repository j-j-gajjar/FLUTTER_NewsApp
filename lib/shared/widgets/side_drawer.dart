import 'dart:async';

import 'package:flutter/material.dart';

import '../../model/category_model.dart';
import '../drawer_list.dart';
import 'drop_down_list.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key, this.onSearchChanged, this.onItemSelected});

  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<SelectableItem>? onItemSelected;

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  Timer? _debounce;
  final Duration _debounceDuration = const Duration(milliseconds: 500);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32),
        children: <Widget>[
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     if (country != null) Text('Country = $cName') else Container(),
          //     const SizedBox(height: 10),
          //     if (category != null) Text('Category = $category') else Container(),
          //     const SizedBox(height: 20),
          //   ],
          // ),
          ListTile(
            title: TextFormField(
              decoration: const InputDecoration(hintText: 'Find Keyword'),
              scrollPadding: const EdgeInsets.all(5),
              onChanged: (String val) {
                if (_debounce?.isActive ?? false) {
                  _debounce!.cancel();
                }

                _debounce = Timer(_debounceDuration, () {
                  widget.onSearchChanged!(val);
                });
              },
            ),
          ),
          ExpansionTile(
            title: const Text('Country'),
            children: <Widget>[
              ...countries.map<Widget>((item) =>
                  DropDownList(
                    onItemSelected: (SelectableItem item) => widget.onItemSelected!(item),
                    item: item,
                  )).toList(),
            ],
          ),
          ExpansionTile(
            title: const Text('Category'),
            children: [
              ...categories.map<Widget>((item) =>
                  DropDownList(
                    onItemSelected: (SelectableItem item) => widget.onItemSelected!(item),
                    item: item,
                  )).toList(),
            ],
          ),
          ExpansionTile(
            title: const Text('Channel'),
            children: [
              ...newsChannels.map<Widget>((item) =>
                  DropDownList(
                    onItemSelected: (SelectableItem item) => widget.onItemSelected!(item),
                    item: item,
                  )).toList(),
            ],
          ),
          //ListTile(title: Text("Exit"), onTap: () => exit(0)),
        ],
      ),
    );
  }
}
