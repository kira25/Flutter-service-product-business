import 'package:formz/formz.dart';

enum InterbankAccountValidationError { invalid }

class InterbankAccount extends FormzInput<String, InterbankAccountValidationError> {
  const InterbankAccount.pure() : super.pure('');
  const InterbankAccount.dirty([String value = '']) : super.dirty(value);

  @override
  InterbankAccountValidationError validator(String value) {
    return value.isNotEmpty == true ? null : InterbankAccountValidationError.invalid;
  }
}
