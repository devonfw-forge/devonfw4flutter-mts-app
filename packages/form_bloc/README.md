# form_bloc

A solution for validating forms using the bloc package.

## How it works

The package provides 2 types of blocs:

### Field Blocs
Responsible for handling the validation and content of one FormField.

### Form Blocs
Responsible for orchestrating a set of FieldBlocs that make up one Form. It hold the content of the complete form and asses wether the complete form is valid or not.

## How to use
First, decide what types of field your form should consist of. Wrap each field of the for with a `BlocBuilder<CheckboxFieldBloc, ValidationState>` like so:

````dart
class BlocFormField extends StatelessWidget {
  final FieldBloc _formFieldBloc;
  final String _label;
  final String _errorHint;

  const BlocFormField({
    Key key,
    @required formFieldBloc,
    @required label,
    @required errorHint,
  })  : _formFieldBloc = formFieldBloc,
        _label = label,
        _errorHint = errorHint,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldBloc, ValidationState>(
      bloc: _formFieldBloc,
      builder: (context, ValidationState state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: _label,
            errorText: validate(state),
          ),
          onChanged: (String input) => _formFieldBloc.dispatch(input),
        );
      },
    );
  }

  String validate(ValidationState state) {
    if (state is InvalidState)
      return _errorHint;
    else
      return null;
  }
}
````

You can chose a FieldBloc based on your validation needs. The package ships with a few out of the boc:
- CheckboxFieldBloc
- DateFieldBloc
- EmailFieldBloc
- NonEmptyFieldBloc
- NumberFieldBloc

But you can also create your own by extending `FieldBloc` and creating your own validation logic.

Once you have a list of FiledBlocs that make up your Form, you need a FormBloc to track the state of the whole Form. You can either use the `FormValidationBloc` that ships with the package, or create your own by extending `FormBaseBloc`. Once you've chose a FormBloc, initialization will look like this:

````dart
//Validation: FieldBlocs
  EmailFieldBloc _emailBloc = EmailFieldBloc();
  DateFieldBloc _dateBloc = DateFieldBloc(DateFormat('dd-MM-yyyy HH:mm'));
  NonEmptyFieldBloc _nameBloc = NonEmptyFieldBloc();
  NumberFieldBloc _guestBloc = NumberFieldBloc();
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();

  //Validation: FormBloc
  YourFormBloc _formBloc;

  @override
  void initState() {
    _formBloc = YourFormBloc(
      emailBloc: _emailBloc,
      dateBloc: _dateBloc,
      nameBloc: _nameBloc,
      guestBloc: _guestBloc,
      termsBloc: _termsBloc,
    );

    super.initState();
  }

...
````

The FormBloc emits validation state based on if all it's FieldBlocs are valid. If all FieldBlocs are valid, the FormBloc is as well.