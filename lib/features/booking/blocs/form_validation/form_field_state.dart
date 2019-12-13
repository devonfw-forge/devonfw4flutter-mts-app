import 'package:equatable/equatable.dart';

abstract class FormFieldState extends Equatable{
  final String text;

  FormFieldState(this.text);
}

class InitialFieldState extends FormFieldState{
  InitialFieldState(String text) : super(text);

  @override
  List<Object> get props => ["initial"];
}

class ValidFieldState extends FormFieldState{
  ValidFieldState(String text) : super(text);

  @override
  List<Object> get props => [text];
}

class InvalidFieldState extends FormFieldState{
  InvalidFieldState(String text) : super(text);

  @override
  List<Object> get props => [text];
}
