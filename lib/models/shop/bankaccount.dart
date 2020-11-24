import 'package:formz/formz.dart';

enum BankAccountValidationError { invalid }

class BankAccount extends FormzInput<String, BankAccountValidationError> {
  const BankAccount.pure() : super.pure('');
  const BankAccount.dirty([String value = '']) : super.dirty(value);

  @override
  BankAccountValidationError validator(String value) {
    return value.isNotEmpty == true ? null : BankAccountValidationError.invalid;
  }
}
