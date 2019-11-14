import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  bool accepted = false;
  final format = DateFormat("dd-MM-yyyy HH:mm");

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
            decoration: const InputDecoration(labelText: 'Date and Time'),
            onShowPicker: (context, currentValue) => onShowPicker(context, currentValue),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Table Guests"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
          ),
          CheckboxListTile(
            title: Text("Accept terms"),
            onChanged: (bool) {
              setState(() {
                accepted = !accepted;
              });
            },
            value: accepted,
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              "Book Table",
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Future<DateTime> onShowPicker(BuildContext context, DateTime currentValue) async {
     final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: currentValue ?? DateTime.now(),
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
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