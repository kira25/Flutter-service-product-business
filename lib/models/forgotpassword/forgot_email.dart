import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class ForgotEmail extends FormzInput<String, EmailValidationError> {
  const ForgotEmail.pure() : super.pure('');
  const ForgotEmail.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError validator(String value) {
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
