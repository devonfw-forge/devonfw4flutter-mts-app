import 'package:flutter/material.dart';

class LabeledCheckBox extends StatelessWidget {
  final String _label;
  final bool _state;
  final Function(bool) _onStateChange;

  const LabeledCheckBox({Key key, label, state, onStateChange})
      : _label = label,
        _state = state,
        _onStateChange = onStateChange,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
          value: _state,
          onChanged: (bool state) => _onStateChange(state),
        ),
        Text(_label),
      ],
    );
  }
}
