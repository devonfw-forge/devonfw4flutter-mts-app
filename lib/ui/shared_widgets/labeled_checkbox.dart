import 'package:flutter/material.dart';

class LabeledCheckBox extends StatefulWidget {
  final String label;

  const LabeledCheckBox({
    Key key,
    @required this.label,
  }) : super(key: key);

  @override
  _LabeledCheckBoxState createState() => _LabeledCheckBoxState();
}

class _LabeledCheckBoxState extends State<LabeledCheckBox> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
          value: checked,
          onChanged: (bool) {
            setState(() {
              checked = !checked;
            });
          },
        ),
        Text(widget.label)
      ],
    );
  }
}
