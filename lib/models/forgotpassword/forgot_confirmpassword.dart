import 'package:formz/formz.dart';
import 'package:service_products_business/models/login/login_models.dart';

enum ConfirmPasswordValidationError { invalid }

class ForgotConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ForgotConfirmPassword.pure() : super.pure('');
  const ForgotConfirmPassword.dirty([String value = '']) : super.dirty(value);
  
  

  @override
  ConfirmPasswordValidationError validator(String value) {
     
    return value.length > 4 ? null : ConfirmPasswordValidationError.invalid;
  }
}
