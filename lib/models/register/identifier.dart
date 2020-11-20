import 'package:formz/formz.dart';

enum IdentifierValidationError { invalid }

class Identifier extends FormzInput<String, IdentifierValidationError> {
  const Identifier.pure() : super.pure('');
  const Identifier.dirty([String value = '']) : super.dirty(value);

  @override
  IdentifierValidationError validator(String value) {
    return value.length == 8 ? null : IdentifierValidationError.invalid;
  }
}
