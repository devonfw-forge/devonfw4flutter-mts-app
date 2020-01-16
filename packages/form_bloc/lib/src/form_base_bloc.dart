import 'package:bloc/bloc.dart';
import 'package:form_bloc/src/field_blocs/field_bloc.dart';
import 'package:form_bloc/src/validation_state.dart';

///Will force the [FormBloc] to update it's [ValidationState]
enum FormEvent { notify }

///Responsible for asserting if a form is valid and what data it carries
///
///The [FormBaseBloc] listens to all the [FieldBloc]s it's given in
///creation. Every time any of the [FieldBloc]s changes state, the
///[FormBaseBloc] checks if all [FieldBloc]s are now valid and emits
///[ValidationState] based on that. [T] defines the data type that the form
///data is emitted at.
///
///An implementation of the FormBaseBloc could look like this:
///
///````dart
///class BookingFormBloc extends FormBaseBloc<Booking> {
///  final EmailFieldBloc _emailBloc;
///  final DateFieldBloc _dateBloc;
///  final NonEmptyFieldBloc _nameBloc;
///  final NumberFieldBloc _guestBloc;
///
///  BookingFormBloc({
///    @required emailBloc,
///    @required dateBloc,
///    @required nameBloc,
///    @required guestBloc,
///  })  : _emailBloc = emailBloc,
///        _dateBloc = dateBloc,
///        _nameBloc = nameBloc,
///        _guestBloc = guestBloc,
///        super([
///          emailBloc,
///          dateBloc,
///          nameBloc,
///          guestBloc,
///        ]);
///
///  @override
///  ValidationState<Booking> get initialState => InitialState(Booking());
///
///  @override
///  Stream<ValidationState<Booking>> mapEventToState(FormEvent event) async* {
///    if (isFormValid()) {
///      yield ValidState(Booking(
///        name: _nameBloc.currentState.data,
///        organizerEmail: _emailBloc.currentState.data,
///        date: _dateBloc.currentState.date,
///        guests: _guestBloc.currentState.data,
///      ));
///    } else {
///      yield InvalidState(Booking(
///        name: _nameBloc.currentState.data,
///        organizerEmail: _emailBloc.currentState.data,
///        date: _dateBloc.currentState.date,
///        guests: _guestBloc.currentState.data,
///      ));
///    }
///  }
///}
///````
///
///More info on the package: https://github.com/devonfw-forge/devonfw4flutter-mts-app/tree/master/packages/form_bloc
abstract class FormBaseBloc<T> extends Bloc<FormEvent, ValidationState<T>> {
  final List<FieldBloc> _fieldBlocs;

  FormBaseBloc(List<FieldBloc> fieldBlocs) : _fieldBlocs = fieldBlocs {
    fieldBlocs.forEach((bloc) {
      bloc.state.listen((_) {
        dispatch(FormEvent.notify);
      });
    });
  }

  ///Checks if the whole form is valid
  ///
  ///If any of the [FieldBloc]s in [_fieldBlocs] is invalid, the
  ///whole form is considered invalid.
  bool isFormValid() {
    bool formIsValid = true;
    _fieldBlocs.forEach((bloc) {
      if (!(bloc.currentState is ValidState)) formIsValid = false;
    });

    return formIsValid;
  }
}
