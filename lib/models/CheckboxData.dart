import 'CheckboxDataItem.dart';

class CheckboxData {
  bool multiple;
  Map<int, CheckboxDataItem> items;

  CheckboxData(bool multiple, List<CheckboxDataItem> items) {
    this.multiple = multiple;
    this.items = {};
    items.forEach((element) {
      this.items.putIfAbsent(element.id, () => element);
    });
  }

  void update(int id, bool value) {
    items[id].value = value;
  }

  dynamic valuesToJson() {
    if (multiple)
      return items
          .map((key, value) => MapEntry(key, value.toJson()))
          .values
          .toList();

    return items.values.firstWhere((element) => element.value).toJson();
  }
}
