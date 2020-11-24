import 'package:formz/formz.dart';

enum WhatsappValidationError { invalid }

class Whatsapp extends FormzInput<String, WhatsappValidationError> {
  const Whatsapp.pure() : super.pure('');
  const Whatsapp.dirty([String value = '']) : super.dirty(value);

  @override
  WhatsappValidationError validator(String value) {
    return value.isNotEmpty == true ? null : WhatsappValidationError.invalid;
  }
}
