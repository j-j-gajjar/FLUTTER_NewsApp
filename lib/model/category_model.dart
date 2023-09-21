import '../shared/drawer_list.dart';

class SelectableItem{
  const SelectableItem({this.name = '', this.code = '', this.type});
  final String name;
  final String code;
  final ListType? type;
}
