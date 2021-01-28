import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final num etat;
  final Function(bool) onChanged;

  CustomCheckBox({
    this.value,
    this.etat,
    this.onChanged,
  });
  @override
  _CustomCheckBoxOneState createState() => _CustomCheckBoxOneState();
}

class _CustomCheckBoxOneState extends State<CustomCheckBox> {
  var value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (bool newValue) {
        if (widget.etat >= 3) return;
        widget.onChanged(newValue);
        setState(() {
          value = newValue;
        });
      },
    );
  }
}
