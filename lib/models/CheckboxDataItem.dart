import 'package:yata_p1/models/constants.dart';

class CheckboxDataItem {
  int id;
  bool value;
  String label;

  Map<String, dynamic> toJson() {
    return {
      ID_KEY: id,
      LABEL_KEY: label,
    };
  }
}
