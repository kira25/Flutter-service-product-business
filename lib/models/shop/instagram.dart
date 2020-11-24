import 'package:formz/formz.dart';

enum InstagramValidationError { invalid }

class Instagram extends FormzInput<String, InstagramValidationError> {
  const Instagram.pure() : super.pure('');
  const Instagram.dirty([String value = '']) : super.dirty(value);

  @override
  InstagramValidationError validator(String value) {
    return value.isNotEmpty == true || value.isEmpty == true
        ? null
        : InstagramValidationError.invalid;
  }
}
