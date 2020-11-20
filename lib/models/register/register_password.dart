import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class RegisterPassword extends FormzInput<String, PasswordValidationError> {
  const RegisterPassword.pure() : super.pure('');
  const RegisterPassword.dirty([String value = '']) : super.dirty(value);
  

  @override
  PasswordValidationError validator(String value) {
    return value.length > 4 ? null : PasswordValidationError.invalid;
  }
}
