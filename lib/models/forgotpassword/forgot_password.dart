import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class ForgotPassword extends FormzInput<String, PasswordValidationError> {
  const ForgotPassword.pure() : super.pure('');
  const ForgotPassword.dirty([String value = '']) : super.dirty(value);
  

  @override
  PasswordValidationError validator(String value) {
    return value.length > 4 ? null : PasswordValidationError.invalid;
  }
}
