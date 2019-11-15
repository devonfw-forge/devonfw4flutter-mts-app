import 'package:flutter/material.dart';

class ExtraCheckBox extends StatefulWidget {
  final String extraName;

  const ExtraCheckBox({
    Key key,
    @required this.extraName,
  }) : super(key: key);

  @override
  _ExtraCheckBoxState createState() => _ExtraCheckBoxState();
}

class _ExtraCheckBoxState extends State<ExtraCheckBox> {
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
        Text(widget.extraName)
      ],
    );
  }
}
