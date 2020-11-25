part of 'forgotpassword_bloc.dart';

abstract class ForgotpasswordEvent extends Equatable {}

class SendEmail extends ForgotpasswordEvent {
  @override
  List<Object> get props => throw UnimplementedError();
 
}

class VerifyPasswordPin extends ForgotpasswordEvent {
  @override
  List<Object> get props => throw UnimplementedError();

}

class PinChanged extends ForgotpasswordEvent {
  final String pin;

  PinChanged({this.pin});
  @override
  List<Object> get props => [pin];
}

class ResetPassword extends ForgotpasswordEvent {
  @override
  List<Object> get props => [];
}

class EmailChanged extends ForgotpasswordEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends ForgotpasswordEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends ForgotpasswordEvent {
  final String confirmpassword;

  ConfirmPasswordChanged(this.confirmpassword);

  @override
  List<Object> get props => [confirmpassword];
}
