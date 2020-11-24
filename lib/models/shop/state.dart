import 'package:formz/formz.dart';

enum StateValidationError { invalid }

class State extends FormzInput<String, StateValidationError> {
  const State.pure() : super.pure('');
  const State.dirty([String value = '']) : super.dirty(value);

  @override
  StateValidationError validator(String value) {
    return value.isNotEmpty == true ? null : StateValidationError.invalid;
  }
}
