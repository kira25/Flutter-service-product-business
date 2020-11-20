import 'package:formz/formz.dart';

enum CellphoneValidationError { invalid }

class Cellphone extends FormzInput<String, CellphoneValidationError> {
  const Cellphone.pure() : super.pure('');
  const Cellphone.dirty([String value = '']) : super.dirty(value);

  @override
  CellphoneValidationError validator(String value) {
    return value.length == 9 ? null : CellphoneValidationError.invalid;
  }
}
