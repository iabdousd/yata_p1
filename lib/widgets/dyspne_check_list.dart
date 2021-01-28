import 'package:flutter/material.dart';

class DyspneCheckList extends StatefulWidget {
  final Size size;
  final List<bool> dyspne;
  final num etat;
  final Function(List<bool>) onChanged;

  DyspneCheckList({
    this.size,
    this.dyspne,
    this.etat,
    this.onChanged,
  });
  @override
  _DyspneCheckListState createState() => _DyspneCheckListState();
}

class _DyspneCheckListState extends State<DyspneCheckList> {
  List<bool> dyspne;

  @override
  void initState() {
    dyspne = widget.dyspne;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width - 60,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: widget.size.width / 50,
        children: <Widget>[
          for (var e = 0; e < dyspne.length; e++)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(
                    value: dyspne[e],
                    onChanged: (bool a) {
                      if (widget.etat >= 3) return;
                      if (a) {
                        for (int d = 0; d < 4; d++) {
                          dyspne[d] = false;
                        }
                        dyspne[e] = true;
                        setState(() {});
                        return;
                      }
                      dyspne[e] = false;
                      setState(() {});
                    },
                  ),
                ),
                Text("Stade ${e + 1}", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
              ],
            )
        ],
      ),
    );
  }
}
