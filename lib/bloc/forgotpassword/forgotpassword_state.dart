part of 'forgotpassword_bloc.dart';

enum FailPinType {success , fail, error }

class ForgotpasswordState {
  final String pin;
  final String passwordtoken;
  final String resetPasswordEmail;
  final ForgotEmail email;
  final ForgotPassword password;
  final ForgotConfirmPassword confirmPassword;
  final FailPinType failPin;
  final bool failSendEmail;
  final FormzStatus status;
  final FormzStatus statusResetPassword;

  ForgotpasswordState(
      {this.failSendEmail = false,
      this.failPin,
      this.email = const ForgotEmail.pure(),
      this.password = const ForgotPassword.pure(),
      this.confirmPassword = const ForgotConfirmPassword.pure(),
      this.pin,
      this.passwordtoken,
      this.resetPasswordEmail,
      this.statusResetPassword = FormzStatus.pure,
      this.status = FormzStatus.pure});

  ForgotpasswordState copyWith(
      {bool failSendEmail,
      FailPinType failPin,
      String pin,
      String passwordtoken,
      String resetPasswordEmail,
      ForgotEmail email,
      ForgotPassword password,
      ForgotConfirmPassword confirmPassword,
      FormzStatus status,
      FormzStatus statusResetPassword}) {
    return ForgotpasswordState(
      failSendEmail:  failSendEmail ?? this.failSendEmail,
        failPin: failPin ?? this.failPin,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordtoken: passwordtoken ?? this.passwordtoken,
        pin: pin ?? this.pin,
        resetPasswordEmail: resetPasswordEmail ?? this.resetPasswordEmail,
        status: status ?? this.status,
        statusResetPassword: statusResetPassword ?? this.statusResetPassword);
  }
}
