import 'package:flutter/material.dart';

class LabeledCheckBox extends StatelessWidget {
  final String label;
  final bool state;
  final Function(bool) onStateChange;

  const LabeledCheckBox({
    Key key,
    @required this.label,
    @required this.state,
    @required this.onStateChange,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
          value: state,
          onChanged: (bool state) => onStateChange(state),
        ),
        Text(label)
      ],
    );
  }
}