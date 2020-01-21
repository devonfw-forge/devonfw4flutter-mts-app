```dart
TextFormField(
  // The validator receives the text that the user has entered.
  validator: (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
);
```