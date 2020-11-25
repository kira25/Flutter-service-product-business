import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { invalid }

class RegisterConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const RegisterConfirmPassword.pure() : super.pure('');
  const RegisterConfirmPassword.dirty([String value = '']) : super.dirty(value);

  @override
  ConfirmPasswordValidationError validator(String value) {
    return value.length > 4 ? null : ConfirmPasswordValidationError.invalid;
  }
}
