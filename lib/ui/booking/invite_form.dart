import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class InviteForm extends StatefulWidget {
  const InviteForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<InviteForm> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy HH:mm");
  bool conditionsAccepted = false;

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          DateTimeField(
            format: format,
            decoration: InputDecoration(labelText: 'Date and Time'),
            onShowPicker: (context, currentValue) =>
                onShowPicker(context, currentValue),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          Padding(
            padding: const EdgeInsets.only(top: UiHelper.card_margin),
            child: Row(
              children: <Widget>[
                Text(
                  "Guests",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter invitation Email'),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          CheckboxListTile(
            title: Text("Accept terms"),
            onChanged: (bool) {
              setState(() {
                conditionsAccepted = !conditionsAccepted;
              });
            },
            value: conditionsAccepted,
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              "Invite Friend",
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Future<DateTime> onShowPicker(
      BuildContext context, DateTime currentValue) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: currentValue ?? DateTime.now(),
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
      );
      return DateTimeField.combine(date, time);
    } else {
      return currentValue;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
