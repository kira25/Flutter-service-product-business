import 'package:formz/formz.dart';

enum FacebookValidationError { invalid }

class Facebook extends FormzInput<String, FacebookValidationError> {
  const Facebook.pure() : super.pure('');
  const Facebook.dirty([String value = '']) : super.dirty(value);

  @override
  FacebookValidationError validator(String value) {
    return value.isNotEmpty == true || value.isEmpty == true
        ? null
        : FacebookValidationError.invalid;
  }
}
