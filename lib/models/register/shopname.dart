import 'package:formz/formz.dart';

enum ShopnameValidationError { invalid }

class Shopname extends FormzInput<String, ShopnameValidationError> {
  const Shopname.pure() : super.pure('');
  const Shopname.dirty([String value = '']) : super.dirty(value);

  @override
  ShopnameValidationError validator(String value) {
    return value.isNotEmpty == true ? null : ShopnameValidationError.invalid;
  }
}
